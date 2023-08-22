import SwiftUI
import UIKit
import GoogleMobileAds

//TabView中に表示させるBanner広告のみのView
struct AdView: View {
    var adUnitIDKey: String

    var body: some View {
        VStack {
            if let adUnitID = Bundle.main.infoDictionary?[adUnitIDKey] as? String {
                AdMobBannerView(adUnitID: adUnitID).frame(width: 300, height: 250)
            } else {
                Text("AdUnitID not found.") // この部分はエラーメッセージや代替の表示を行う
            }
        }
        .analyticsScreen(name: "ads_content")
    }
}

//Banner
struct AdMobBannerView: UIViewRepresentable {
    let adUnitID: String

    init(adUnitID: String) {
        self.adUnitID = adUnitID
    }

    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeMediumRectangle)
        banner.adUnitID = adUnitID
        
//        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        banner.rootViewController = window?.rootViewController
        
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}

