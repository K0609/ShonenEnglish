import SwiftUI

struct EndView: View {
    @EnvironmentObject var comicViewModel: ComicViewModel
    @Binding var selectedIndex: Int
    @Binding var isBarVisible: Bool
    var selectedLevel: Int

    var body: some View {
        VStack(spacing: 20) {
            //次の学習へ進むボタン
            Button(action: {
                // 上下のバーの動作制御
                BarVisibilityPublisher.shared.ChangeBarVisibility()
                
                // レベルチェック
                if selectedLevel == 0 {
                    comicViewModel.loadRandomComics()
                } else {
                    comicViewModel.loadComicsWithWordLevel(level: selectedLevel)
                }
                
                // 先頭ページを表示
                selectedIndex = 0
            }) {
                HStack {
                    Image(systemName: "forward")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("NEXT")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 3)
            }

            //先頭ページへ戻るボタン
            Button(action: {
                // 上下のバーの動作制御
                BarVisibilityPublisher.shared.ChangeBarVisibility()
                // 先頭ページを表示
                selectedIndex = 0
            }) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("AGAIN")
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
        }
        .padding()
    }
}
