import Foundation
import SwiftUI
import Combine

class BarVisibilityPublisher: ObservableObject {
    static let shared = BarVisibilityPublisher() // Singleton instance
    let objectWillChange = PassthroughSubject<Void, Never>()

    func ChangeBarVisibility() {
        objectWillChange.send()
    }
}
