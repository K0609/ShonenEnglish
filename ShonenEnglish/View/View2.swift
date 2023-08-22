import SwiftUI
import AVFoundation
import GoogleMobileAds

struct View2: View {
    @EnvironmentObject var comicViewModel: ComicViewModel
    let comicData: ComicData
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    @State private var bannerAdView: GADBannerView = GADBannerView(adSize: GADAdSizeBanner)

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center, spacing: 15) {
                    // 漫画画像，英語のセリフ、日本語のセリフ、キャラクター名
                    CardView {
                        VStack(alignment: .leading) {
                            
                            //画像
                            Image(uiImage: comicData.image ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width - 60, height: geometry.size.height / 3) // 10 (左のpadding) + 10 (右のpadding) + 10 (余分な幅)
                                .background(.primary)
                                .padding(.trailing, 5)
                            
                            HStack {
                                Spacer()
                                if comicData.isJapanese {
                                    Text("\(comicData.localizedAuthor())『\(comicData.localizedTitle())』\(comicData.volume)巻")
                                        .font(.footnote)
                                        .layoutPriority(1)
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                } else {
                                    Text("\(comicData.localizedAuthor())『\(comicData.localizedTitle())』vol.\(comicData.volume)")
                                        .font(.footnote)
                                        .layoutPriority(1)
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                }
                            }
                            .foregroundColor(.gray)
                            .padding(.trailing, 5)
                            
                            HStack {
                                Spacer()
                                Text("\(comicData.localizedPublication()) / \(comicData.localizedPublisher())")
                                    .font(.footnote)
                                    .layoutPriority(1)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                            }
                            .foregroundColor(.gray)
                            .padding(.trailing, 5)
                            
                            //アイコン
                            HStack {
                                Image(systemName: "quote.opening")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            //セリフ
                            QuoteView(quote: comicData.quoteJa,
                                      language: "ja-JP",
                                      highlightWords: comicData.quoteJaHighlight,
                                      highlightWordsSub: comicData.quoteJaHighlightSub
                            )
                                .padding(.bottom, 10)
                            QuoteView(quote: comicData.quoteEn,
                                      language: "en-US",
                                      highlightWords: comicData.quoteEnHighlight,
                                      highlightWordsSub: comicData.quoteEnHighlightSub
                            )
                                .padding(.bottom, 10)
                            
                            //キャラクター名
                            HStack {
                                Text(comicData.localizedCharacter())
                                    .bold()
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            .padding(.leading, 28)
                        }
                        .padding(.leading, 5)
                    }
                    .frame(width: geometry.size.width - 20)
                    
                    // 辞書的な情報
                    CardView {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            //単語名
                            Text(comicData.wordEn)
                                .font(.title)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            
                            //発音
                            HStack {
                                //音声ボタン
                                Button(action: {
                                    // Trigger the bar hide event
                                    BarVisibilityPublisher.shared.ChangeBarVisibility()
                                    speechSynthesizer.speak(comicData.wordEn, language: "en-US")
                                }) {
                                    Image(systemName: "speaker.wave.3.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                                
                                //発音記号
                                Text("\(comicData.pronUS)")
                                    .font(.subheadline)
                                
                                Spacer()
                            }
                            
                            //レベル
                            HStack {
                                Image(systemName: "chart.bar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Lv: \(comicData.wordLevel)")
                                Spacer()
                            }
                            
                            // 品詞1
                            POSView(pos: comicData.localizedPOS1(), conjugation: comicData.conjugation1, meanings: [
                                (comicData.meaningJa1_1, comicData.synonymEn1_1),
                                (comicData.meaningJa1_2, comicData.synonymEn1_2),
                                (comicData.meaningJa1_3, comicData.synonymEn1_3)
                            ])
                            
                            // 品詞2
                            if !comicData.POS2.isEmpty {
                                POSView(pos: comicData.localizedPOS2(), conjugation: comicData.conjugation2, meanings: [
                                    (comicData.meaningJa2_1, comicData.synonymEn2_1),
                                    (comicData.meaningJa2_2, comicData.synonymEn2_2),
                                    (comicData.meaningJa2_3, comicData.synonymEn2_3)
                                ])
                            }
                        }
                        .padding(.leading, 5)
                    }
                    .frame(width: geometry.size.width - 20)
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
//                .frame(minHeight: geometry.size.height)
            }
        }
        .analyticsScreen(name: "main_content")
    }
}

// カードビュー
struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(UIColor.systemBackground))
                .shadow(color: Color.gray, radius: 3)
            content.padding()
        }
    }
}

//セリフビュー
struct QuoteView: View {
    let quote: String
    let language: String
    let highlightWords: [String]
    let highlightWordsSub: [String]
    @StateObject private var speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        HStack(alignment: .top) {
            // Speaker Button
            speakerButton

            // Quote Text
            highlightSwiftUIText()
                .font(.body)
                .bold()
                .layoutPriority(1)
                .lineLimit(nil) // 無限の行数を許可

            Spacer(minLength: 5)
        }
    }
    
    // 指定文字列のハイライト
    private func highlightSwiftUIText() -> some View {
        let highlighter = TextHighlighter(quote: quote, highlightWords: highlightWords, highlightWordsSub: highlightWordsSub)
        return highlighter.highlightedText().reduce(Text(""), +)
    }

    // 発音機能のスピーカーアイコンのボタン
    private var speakerButton: some View {
        Button(action: {
            BarVisibilityPublisher.shared.ChangeBarVisibility()
            speechSynthesizer.speak(quote, language: language)
        }) {
            Image(systemName: "speaker.wave.3.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .font(.body)
    }
}

// 品詞ビュー
struct POSView: View {
    let pos: String
    let conjugation: String
    let meanings: [(String?, String?)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            //アイコンと品詞名
            HStack {
                Image(systemName: "character.book.closed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text(pos)
                    .font(.title3)
                    .bold()
                
                Spacer()
            }
            
            //活用
            if !conjugation.isEmpty {
                
                HStack {
                    Image(systemName: "paperclip")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text(conjugation)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                .padding(.leading, 30)

            }
            
            ForEach(meanings, id: \.0) { meaning in
                MeaningView(meaningJa: meaning.0, synonymEn: meaning.1)
                    .padding(.leading, 30)
            }
        }
    }
}

// 意味ビュー
struct MeaningView: View {
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    let meaningJa: String?
    let synonymEn: String?

    @ViewBuilder
    var body: some View {
        if let meaningJa = meaningJa, let synonymEn = synonymEn, !meaningJa.isEmpty, !synonymEn.isEmpty {
            HStack {
                //音声ボタン
                Button(action: {
                    // Trigger the bar hide event
                    BarVisibilityPublisher.shared.ChangeBarVisibility()
                    speechSynthesizer.speak(meaningJa, language: "ja-Ja")
                    speechSynthesizer.speak(synonymEn, language: "en-US")
                }) {
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Text(meaningJa).bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                HStack(alignment: .bottom, spacing: 0) {
                    Image(systemName: "pin")
                        .font(.caption2)
                    Text("\(synonymEn)")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                .padding(.leading, 0)
            }
        } else if let meaningJa = meaningJa, !meaningJa.isEmpty {
            HStack {
                //音声ボタン
                Button(action: {
                    // Trigger the bar hide event
                    BarVisibilityPublisher.shared.ChangeBarVisibility()
                    speechSynthesizer.speak(meaningJa, language: "ja-Ja")
                }) {
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Text(meaningJa).bold()  // synonymEnがnilの場合でも、meaningJaがある場合はそのまま表示
                    .fixedSize(horizontal: false, vertical: true)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
        } else {
            EmptyView()  // meaningJaがnilの場合は何も表示しない
        }
    }
}
