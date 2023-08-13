import SwiftUI

struct ContentView: View {
    
    var comicData = ComicData(
        quoteID: 1,
        quoteJa: "俺がなるって決めたんだから その為に戦って死ぬんなら別にいい",
        characterJa: "モンキー・D・ルフィ",
        titleJa: "ONE PIECE",
        authorJa: "尾田栄一郎",
        publicationJa: "週刊少年ジャンプ",
        volume: 1,
        quoteEn: "I decided to become it, so if I have to fight and die for that, I don't mind!",
        wordID: 1,
        wordEn: "become",
        wordJa: "なる",
        wordLevel: 2,
        pronUS: "/bɪˈkʌm/",
        pronUK: "/bɪˈkʌm/",
        POS1: "動",
        conjugation1: "<動> becomes - becoming - became - become",
        meaningJa1_1: "〜になる",
        meaningJa1_2: "〜となる",
        meaningJa1_3: "〜に変わる",
        synonymEn1_1: "turn into",
        synonymEn1_2: "evolve into",
        synonymEn1_3: "transform into",
        POS2: "",
        conjugation2: "",
        meaningJa2_1: "",
        meaningJa2_2: "",
        meaningJa2_3: "",
        synonymEn2_1: "",
        synonymEn2_2: "",
        synonymEn2_3: "",
        characterEn: "",
        titleEn: "",
        authorEn: "",
        publicationEn: ""
    )

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    //画像
                    VStack(alignment: .trailing, spacing: 3) {
                        Image("\(comicData.quoteID)")
                            .resizable()
                            .scaledToFit()
                            .shadow(color: Color.black.opacity(0.7), radius: 10)
                        
                        HStack {
                            Spacer()
                            Text("\(comicData.authorJa)『\(comicData.titleJa)』\(comicData.volume)巻 (掲載誌：\(comicData.publicationJa))")
                                .font(.footnote)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        .foregroundColor(.gray)
                    }
                    
                    //単語
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(comicData.wordEn)
                                .font(.largeTitle)
                                .bold()
                            
                            Spacer()

                            Button(action: {
//                                speechSynthesizer.speak(comicData.wordEn, language: "en-US")
                            }) {
                                Image(systemName: "speaker.wave.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }

                        HStack {
                            Text(comicData.wordJa)
                                .font(.title)
                                .bold()

                            Spacer()
                            
                            Button(action: {
//                                speechSynthesizer.speak(comicData.wordJa, language: "ja-JP")
                            }) {
                                Image(systemName: "speaker.wave.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    
                    //セリフ
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            //英語のセリフ
                            HStack {
                                Text(comicData.quoteEn)
                                    .font(.body)
                                    .italic()

                                Spacer()

                                Button(action: {
//                                    speechSynthesizer.speak(comicData.quoteEn, language: "en-US")
                                }) {
                                    Image(systemName: "speaker.wave.3.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            
                            // 日本語のセリフ
                            HStack {
                                Text(comicData.quoteJa)
                                    .font(.body)
                                    .italic()

                                Spacer()
                                
                                Button(action: {
//                                    speechSynthesizer.speak(comicData.quoteJa, language: "ja-JP")
                                }) {
                                    Image(systemName: "speaker.wave.3.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }

                        // キャラクター名
                        Text(comicData.characterJa)
                            .font(.body)
                        
                        // 辞書的な情報
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                HStack {
//                                    Image(systemName: "speaker")
                                    Text(comicData.pronUS)
                                        .font(.subheadline)
                                }
                                        
                                HStack {
//                                    Image(systemName: "chart.line.uptrend.xyaxis")
                                    Text("\(comicData.wordLevel)")
                                        .font(.subheadline)
                                }
                            }
 

                            
                            Text(comicData.POS1)
                                .font(.subheadline)
                            
                            Text(comicData.conjugation1)
                                .font(.subheadline)
                            
                            Text(comicData.meaningJa1_1)
                                .font(.subheadline)
                            Text(comicData.meaningJa1_2)
                                .font(.subheadline)
                            Text(comicData.meaningJa1_3)
                                .font(.subheadline)
                        }
                        .padding(.top, 10) // add spacing
                    }
                }
                .padding()
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
