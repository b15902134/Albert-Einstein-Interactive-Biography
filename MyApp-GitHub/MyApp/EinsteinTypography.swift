import CoreText
import Foundation
import SwiftUI
import UIKit

enum EinsteinTypography {
    static let displayFontName = "CormorantGaramond-SemiBold"
    static let chineseFontName = "TW-Kai-98_1"

    static func registerBundledFont() {
        registerFont(fileName: "CormorantGaramond-VariableFont_wght")
        registerFont(fileName: "TW-Kai-98_1")
    }

    static func font(size: CGFloat, textStyle: UIFont.TextStyle) -> Font {
        let primaryFont = UIFont(name: displayFontName, size: size)
            ?? UIFont.systemFont(ofSize: size)
        let chineseDescriptor = UIFontDescriptor(name: chineseFontName, size: size)
        let cascadedDescriptor = primaryFont.fontDescriptor.addingAttributes([
            .cascadeList: [chineseDescriptor]
        ])
        let cascadedFont = UIFont(descriptor: cascadedDescriptor, size: size)
        let scaledFont = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: cascadedFont)
        return Font(scaledFont)
    }

    private static func registerFont(fileName: String) {
        let fontURL = Bundle.main.url(forResource: fileName, withExtension: "ttf", subdirectory: "Fonts")
            ?? Bundle.main.url(forResource: fileName, withExtension: "ttf")

        guard let fontURL else { return }
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
    }
}

extension Font {
    static var einsteinLargeTitle: Font { EinsteinTypography.font(size: 34, textStyle: .largeTitle) }
    static var einsteinTitle: Font { EinsteinTypography.font(size: 28, textStyle: .title1) }
    static var einsteinTitle2: Font { EinsteinTypography.font(size: 22, textStyle: .title2) }
    static var einsteinTitle3: Font { EinsteinTypography.font(size: 20, textStyle: .title3) }
    static var einsteinHeadline: Font { EinsteinTypography.font(size: 17, textStyle: .headline) }
    static var einsteinBody: Font { EinsteinTypography.font(size: 17, textStyle: .body) }
    static var einsteinSubheadline: Font { EinsteinTypography.font(size: 15, textStyle: .subheadline) }
    static var einsteinCaption: Font { EinsteinTypography.font(size: 12, textStyle: .caption1) }
    static var einsteinCaption2: Font { EinsteinTypography.font(size: 11, textStyle: .caption2) }
}

struct SpacetimePortraitShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.84))
        path.addCurve(
            to: CGPoint(x: rect.minX, y: rect.height * 0.94),
            control1: CGPoint(x: rect.width * 0.72, y: rect.height * 0.76),
            control2: CGPoint(x: rect.width * 0.30, y: rect.height * 1.02)
        )
        path.closeSubpath()
        return path
    }
}
