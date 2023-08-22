import SwiftUI
import FirebaseCore
import Firebase
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      //Firebaseの初期化
      FirebaseApp.configure()
      
      // Initialize the Google Mobile Ads SDK.
          GADMobileAds.sharedInstance().start(completionHandler: nil)
      
      return true
  }
}

@main
struct ShonenEnglishApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var comicViewModel = ComicViewModel()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(comicViewModel)
        }
    }
}
