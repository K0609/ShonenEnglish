import SwiftUI
import UIKit

struct TabViewWrapper: View {
    @EnvironmentObject var comicViewModel: ComicViewModel
    @Binding var selectedIndex: Int
    @Binding var showModal: Bool
    var selectedLevel: Int
    @State private var isBarVisible = false
    var selectedModeLa: Int // 日本語->EngかEng->日本語か
    var selectedModeWorS: Int //単語か文章か
    private let adViewCount: Int = 2
    
    var body: some View {
        ZStack {
            //本画面
            TabView(selection: $selectedIndex) {
                // EndView
                EndView(selectedIndex: $selectedIndex, isBarVisible: $isBarVisible, selectedLevel: selectedLevel)
                    .tag(comicViewModel.comicDataList.count * 2 + adViewCount) // AdViewの数を考慮してtagを更新
                
                // AdViewを指定した数だけ表示
                ForEach((1...adViewCount).reversed(), id: \.self) { adIndex in
                    let adUnitIDKey = adIndex == 1 ? "AdMobBannerUnitID1" : "AdMobBannerUnitID2"
                    AdView(adUnitIDKey: adUnitIDKey)
                            .tag(comicViewModel.comicDataList.count * 2 + adIndex - 1)
                }
                
                //View1とView2
                ForEach((0..<comicViewModel.comicDataList.count * 2).reversed(), id: \.self) { index in
                    if index % 2 == 0 {
                        View1(comicData: comicViewModel.comicDataList[index / 2], selectedModeLa: selectedModeLa, selectedModeWorS: selectedModeWorS)
                            .tag(index)
                    } else {
                        View2(comicData: comicViewModel.comicDataList[(index - 1) / 2])
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .simultaneousGesture(TapGesture().onEnded {_ in
                withAnimation(.easeInOut) {
                    isBarVisible.toggle()
                }
            })
            
            //isBarVisibeがtrueのとき、上下のバーを表示させる
            if isBarVisible {
                //上部のバー
                VStack {
                    HStack {
                        //閉じるボタン
                        Button(action: {
                            showModal = false
                            selectedIndex = 0
                        }) {
                            Image(systemName: "xmark")
                                .bold()
                                .foregroundColor(.primary)
                                .padding()
                        }
                        
                        Spacer()
                        
//                        //お気に入りボタン
//                        Image(systemName: "star")
//                            .foregroundColor(.white)
//                            .padding()
                    }
                    .background(Color(UIColor.secondarySystemBackground).opacity(0.9))
                    Spacer()
                }
                .transition(.move(edge: .top)) // スライドイン/スライドアウトアニメーション

                //下部のバー
                VStack {
                    Spacer()

                    HStack {
                        //EndViewへ
                        Button(action: {
                            selectedIndex = comicViewModel.comicDataList.count * 2 + adViewCount
                        }) {
                            Image(systemName: "arrowshape.left.fill")
                                .foregroundColor(.primary)
                                .padding()
                        }
                        
                        Spacer()
                        
                        //先頭ページへ
                        Button(action: {
                            selectedIndex = 0
                        }) {
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundColor(.primary)
                                .padding()
                        }
                    }
                    .background(Color(UIColor.secondarySystemBackground).opacity(0.9))
                }
                .transition(.move(edge: .bottom)) // スライドイン/スライドアウトアニメーション
            }
        }
        .animation(.easeInOut, value: isBarVisible) // isBarVisible変更時のアニメーションを指定
        .animation(.easeInOut, value: isBarVisible) // isBarVisible変更時のアニメーションを指定
        .onReceive(BarVisibilityPublisher.shared.objectWillChange) { _ in
            withAnimation {
                isBarVisible.toggle()
            }
        }
    }
}
