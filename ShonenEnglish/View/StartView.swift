import SwiftUI
import FirebaseAnalyticsSwift

struct StartView: View {
    @EnvironmentObject var comicViewModel: ComicViewModel
    @Binding var showModal: Bool
    @State private var selectedIndex = 0
    @State private var selectedLevel = 1.0  // 学習レベル
    @State private var isRandom = true  // 学習レベルランダム
    @State private var selectedModeLa = 0 // 学習モード 日本語->EngかEng->日本語か
    @State private var selectedModeWorS = 0 // 学習モード 単語か文章か

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        //レベル
                        HStack {
                            Text("LEVEL")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text(isRandom ? "" : "\(Int(selectedLevel))")
                                .font(.title)
                                .fontWeight(.semibold)

                            Spacer()
                            
                            Text("Random")
                            Toggle("", isOn: $isRandom)
                                .labelsHidden()
                        }
                        //スライダー
                        Slider(value: $selectedLevel,
                               in: 1...10,
                               step: 1,
                               minimumValueLabel: Text("1").font(.footnote), // 最小ラベル
                               maximumValueLabel: Text("10").font(.footnote),  // 最大ラベル
                               label: { EmptyView() }
                        )
                            .accentColor(.red)
                            .disabled(isRandom)
                        
                        //モード
                        Text("MODE")
                            .font(.title)
                            .fontWeight(.semibold)
                        //日本語->EngかEng->日本語か
                        Picker(selection: $selectedModeLa, label: Text("")) {
                            Text("ENGLISH ⇢ 日本語")
                                .tag(0)
                            Text("日本語 ⇢ ENGLISH")
                                .tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        //単語か文章か
                        Picker(selection: $selectedModeWorS, label: Text("")) {
                            Text("WORD").tag(0)
                            Text("QUOTE").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
                
                //スタートボタン
                Button(action: {
                    if isRandom {  // 修正
                        comicViewModel.loadRandomComics()
                    } else {
                        comicViewModel.loadComicsWithWordLevel(level: Int(selectedLevel))
                    }
                    withAnimation {
                        showModal.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "play")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("START")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.customBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3)
                }
                .padding([.leading, .trailing], 20)
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showModal) {
            TabViewWrapper(selectedIndex: $selectedIndex,
                           showModal: $showModal,
                           selectedLevel: isRandom ? 0 : Int(selectedLevel),
                           selectedModeLa: selectedModeLa,
                           selectedModeWorS: selectedModeWorS
            )
        }
        .analyticsScreen(name: "main_content")
    }
}
