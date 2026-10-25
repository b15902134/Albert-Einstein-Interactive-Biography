import SwiftUI

struct TheoryDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    let theory: TheoryDetail

    var body: some View {
        NavigationStack {
            ScrollView {
                TheoryDerivationCard(theory: theory)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
            }
            .background(Color.einsteinNavy.opacity(0.035))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(theory.title)
                        .font(.einsteinHeadline)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("完成")
                            .font(.einsteinHeadline)
                    }
                }
            }
        }
    }
}

struct TheoryDerivationSection: View {
    let theories: [TheoryDetail]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SectionHeader(
                eyebrow: "Theory Laboratory",
                title: "從假設到方程",
                subtitle: "以下推導保留每套理論的核心邏輯，並標明近似條件。完整張量計算與統計積分遠超單頁篇幅，但關鍵步驟不以比喻取代。"
            )

            LazyVStack(spacing: 22) {
                ForEach(theories) { theory in
                    TheoryDerivationCard(theory: theory)
                }
            }
        }
    }
}

struct TheoryDerivationCard: View {
    let theory: TheoryDetail

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Text(theory.number)
                .font(.custom(EinsteinTypography.displayFontName, size: 108))
                .foregroundStyle(theory.accent.opacity(0.07))
                .offset(x: 4, y: -24)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 24) {
                TheoryTitle(
                    number: theory.number,
                    icon: theory.icon,
                    title: theory.title,
                    subtitle: theory.subtitle,
                    accent: theory.accent
                )
                TheoryProblem(text: theory.problem)
                AssumptionList(items: theory.assumptions, accent: theory.accent)

                VStack(spacing: 0) {
                    ForEach(theory.steps.enumerated(), id: \.element.id) { index, step in
                        DerivationStepView(
                            step: step,
                            stepNumber: index + 1,
                            isLast: index == theory.steps.count - 1,
                            accent: theory.accent
                        )
                    }
                }

                TheoryResult(text: theory.result, symbols: theory.symbols, accent: theory.accent)
            }
        }
        .padding(22)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(theory.accent.opacity(0.22), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct TheoryTitle: View {
    let number: String
    let icon: String
    let title: String
    let subtitle: String
    let accent: Color

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.einsteinTitle2)
                .foregroundStyle(accent)
                .frame(width: 48, height: 48)
                .background(accent.opacity(0.14), in: Circle())

            VStack(alignment: .leading, spacing: 5) {
                Text("THEORY \(number)")
                    .font(.einsteinCaption2.bold())
                    .tracking(1.5)
                    .foregroundStyle(accent)
                Text(title)
                    .font(.einsteinTitle2.bold())
                Text(subtitle)
                    .font(.einsteinSubheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

struct TheoryProblem: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Label("要解決的問題", systemImage: "questionmark.circle.fill")
                .font(.einsteinCaption.bold())
                .foregroundStyle(.secondary)
            Text(text)
                .font(.einsteinSubheadline)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct AssumptionList: View {
    let items: [String]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text("前提與適用條件")
                .font(.einsteinCaption.bold())
                .foregroundStyle(.secondary)

            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: 9) {
                    Circle()
                        .fill(accent)
                        .frame(width: 6, height: 6)
                        .padding(.top, 6)
                    Text(item)
                        .font(.einsteinCaption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.08), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct DerivationStepView: View {
    let step: DerivationStep
    let stepNumber: Int
    let isLast: Bool
    let accent: Color

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                Text("\(stepNumber)")
                    .font(.einsteinCaption2.bold().monospacedDigit())
                    .foregroundStyle(Color.einsteinNavy)
                    .frame(width: 28, height: 28)
                    .background(accent, in: Circle())

                if !isLast {
                    Rectangle()
                        .fill(accent.opacity(0.25))
                        .frame(width: 1.5, height: 138)
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(step.title)
                    .font(.einsteinSubheadline.bold())

                LaTeXText(
                    latex: step.equation,
                    pointSize: 20,
                    weight: .semibold,
                    color: UIColor(accent)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background(Color.einsteinNavy, in: RoundedRectangle(cornerRadius: 14, style: .continuous))

                Text(step.explanation)
                    .font(.einsteinCaption)
                    .foregroundStyle(.secondary)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, isLast ? 0 : 18)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

struct TheoryResult: View {
    let text: String
    let symbols: String
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("物理結論", systemImage: "checkmark.seal.fill")
                .font(.einsteinSubheadline.bold())
                .foregroundStyle(accent)

            Text(text)
                .font(.einsteinSubheadline)
                .fixedSize(horizontal: false, vertical: true)

            Divider()

            Text(symbols)
                .font(.einsteinCaption2)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(15)
        .background(accent.opacity(0.09), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
