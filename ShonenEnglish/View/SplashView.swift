import SwiftUI

struct SplashView: View {
    @EnvironmentObject var comicViewModel: ComicViewModel
    @State private var isActive = false
    @State private var showModal = false

    var body: some View {
        VStack {
            if isActive {
                StartView(showModal: $showModal)
            } else {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.8)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .background(Color.customBlue) // ここで背景色を設定
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}
