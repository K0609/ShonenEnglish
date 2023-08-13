import SwiftUI

extension Color {
    static let customBlue = Color(red: 0.0/255.0, green: 19.0/255.0, blue: 255.0/255.0)

    // 16進数での色指定も追加可能
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
