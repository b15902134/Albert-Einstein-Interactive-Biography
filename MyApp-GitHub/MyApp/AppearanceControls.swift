import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: LocalizedStringResource {
        switch self {
        case .system: "跟隨系統"
        case .light: "淺色模式"
        case .dark: "深色模式"
        }
    }

    var icon: String {
        switch self {
        case .system: "circle.lefthalf.filled"
        case .light: "sun.max.fill"
        case .dark: "moon.stars.fill"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}

struct AppearanceMenu: View {
    @Binding var selection: AppAppearance
    let effectiveColorScheme: ColorScheme
    @State private var isShowingOptions = false

    var body: some View {
        Image(systemName: selection.icon)
            .font(.einsteinHeadline)
            .contentTransition(.symbolEffect(.replace))
            .symbolEffect(.bounce, value: selection)
            .foregroundStyle(.white)
            .frame(width: 44, height: 44)
            .background(.ultraThinMaterial, in: Circle())
            .overlay {
                Circle()
                    .stroke(.white.opacity(0.24), lineWidth: 1)
                    .allowsHitTesting(false)
            }
            .contentShape(Circle())
            .onTapGesture {
                withAnimation(.smooth) {
                    selection = effectiveColorScheme == .dark ? .light : .dark
                }
            }
            .onLongPressGesture {
                isShowingOptions = true
            }
            .popover(isPresented: $isShowingOptions, arrowEdge: .top) {
                VStack(spacing: 4) {
                    Text("外觀模式")
                        .font(.einsteinCaption.bold())
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 4)

                    ForEach(AppAppearance.allCases) { appearance in
                        Button {
                            selection = appearance
                            isShowingOptions = false
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: appearance.icon)
                                    .frame(width: 22)
                                Text(appearance.title)
                                    .font(.einsteinBody)
                                Spacer()
                                if selection == appearance {
                                    Image(systemName: "checkmark")
                                        .font(.einsteinCaption.bold())
                                }
                            }
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 10)
                            .frame(height: 44)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(8)
                .frame(width: 240)
                .presentationCompactAdaptation(.popover)
            }
            .accessibilityElement()
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel("切換外觀模式")
            .accessibilityValue(Text(selection.title))
            .accessibilityHint("點兩下快速切換淺色與深色，長按顯示所有模式")
            .accessibilityAction {
                selection = effectiveColorScheme == .dark ? .light : .dark
            }
    }
}
