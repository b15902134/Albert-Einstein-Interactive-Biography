import SwiftUI

struct SectionHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(eyebrow.uppercased())
                .font(.einsteinCaption.weight(.bold))
                .tracking(2)
                .foregroundStyle(Color.einsteinGold)

            Text(title)
                .font(EinsteinTypography.font(size: 34, textStyle: .title1))
                .fontWeight(.semibold)
                .foregroundStyle(.primary)

            Text(subtitle)
                .font(.einsteinBody)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

struct EinsteinCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .opacity(configuration.isPressed ? 0.86 : 1)
            .animation(.smooth(duration: 0.18), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == EinsteinCardButtonStyle {
    static var einsteinCard: EinsteinCardButtonStyle {
        EinsteinCardButtonStyle()
    }
}

extension Color {
    static let einsteinNavy = Color(red: 0.035, green: 0.09, blue: 0.15)
    static let einsteinGold = Color(red: 0.84, green: 0.64, blue: 0.27)
    static let einsteinCard = Color.primary.opacity(0.055)
}
