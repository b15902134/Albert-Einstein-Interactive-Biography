import SwiftUI

struct ScientificPapersSection: View {
    let papers: [ScientificPaper]
    let onSelectPaper: (ScientificPaper) -> Void
    private let columns = [GridItem(.adaptive(minimum: 250), spacing: 12)]

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            SectionHeader(
                eyebrow: "Annus Mirabilis · Original papers",
                title: "1905 年原始論文",
                subtitle: "四篇論文，四種不同問題。點開卡片閱讀完整書目、論證結構、方程與歷史意義。"
            )

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(papers) { paper in
                    Button {
                        onSelectPaper(paper)
                    } label: {
                        ScientificPaperCard(paper: paper)
                    }
                    .buttonStyle(.einsteinCard)
                    .accessibilityHint("開啟論文內容")
                }
            }
        }
    }
}

struct ScientificPaperCard: View {
    let paper: ScientificPaper

    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: paper.icon)
                .font(.einsteinTitle3)
                .foregroundStyle(paper.accent)
                .frame(width: 42, height: 42)
                .background(paper.accent.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(paper.number)
                    .font(.einsteinCaption2.bold())
                    .foregroundStyle(paper.accent)

                Text(paper.chineseTitle)
                    .font(.einsteinSubheadline.bold())
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Text("1905 · 完整論文")
                    .font(.einsteinCaption2)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 4)

            Image(systemName: "chevron.right")
                .font(.einsteinCaption.bold())
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity, minHeight: 82, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(paper.accent.opacity(0.22), lineWidth: 1)
        }
        .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct ScientificPaperDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    let paper: ScientificPaper

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    PaperIdentityHeader(paper: paper)
                    PaperEditionNotice(text: paper.editorialNote, accent: paper.accent)
                    PaperAbstractSection(text: paper.abstract)
                    PaperQuestionSection(question: paper.researchQuestion)
                    PaperArgumentSection(arguments: paper.argument, accent: paper.accent)
                    PaperEquationsSection(equations: paper.equations, accent: paper.accent)
                    PaperFullTextSection(chapters: paper.chapters, accent: paper.accent)
                    PaperConclusionSection(
                        conclusion: paper.conclusion,
                        historicalImpact: paper.historicalImpact,
                        accent: paper.accent
                    )
                }
                .frame(maxWidth: 760)
                .padding(20)
                .frame(maxWidth: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("論文內容")
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
        .interactiveDismissDisabled()
    }
}

struct PaperEditionNotice: View {
    let text: String
    let accent: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "text.book.closed.fill")
                .foregroundStyle(accent)
            VStack(alignment: .leading, spacing: 5) {
                Text("版本說明")
                    .font(.einsteinCaption.bold())
                Text(text)
                    .font(.einsteinCaption)
                    .foregroundStyle(.secondary)
                    .lineSpacing(3)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(accent.opacity(0.1), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct PaperAbstractSection: View {
    let text: String

    var body: some View {
        PaperTextBlock(title: "摘要", icon: "doc.plaintext.fill", text: text)
    }
}

struct PaperIdentityHeader: View {
    let paper: ScientificPaper

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(paper.number, systemImage: paper.icon)
                .font(.einsteinCaption.bold())
                .foregroundStyle(paper.accent)

            Text(paper.chineseTitle)
                .font(.einsteinTitle.bold())

            Text(paper.germanTitle)
                .font(.einsteinSubheadline.italic())
                .foregroundStyle(.secondary)

            Divider()

            VStack(alignment: .leading, spacing: 5) {
                Text("投稿：\(paper.submitted)　出版：\(paper.published)")
                Text(paper.citation)
                Text("DOI: \(paper.doi)")
                Text(.init("[開啟 DOI 原始論文](https://doi.org/\(paper.doi))"))
                    .foregroundStyle(paper.accent)
            }
            .font(.einsteinCaption)
            .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

struct PaperQuestionSection: View {
    let question: String

    var body: some View {
        PaperTextBlock(title: "研究問題", icon: "questionmark.circle.fill", text: question)
    }
}

struct PaperArgumentSection: View {
    let arguments: [String]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("論證結構", systemImage: "list.number")
                .font(.einsteinHeadline)

            ForEach(arguments.enumerated(), id: \.element) { index, argument in
                HStack(alignment: .top, spacing: 12) {
                    Text("\(index + 1)")
                        .font(.einsteinCaption.bold().monospacedDigit())
                        .foregroundStyle(Color.einsteinNavy)
                        .frame(width: 26, height: 26)
                        .background(accent, in: Circle())
                    Text(argument)
                        .font(.einsteinSubheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct PaperEquationsSection: View {
    let equations: [PaperEquation]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("核心方程", systemImage: "function")
                .font(.einsteinHeadline)

            ForEach(equations) { equation in
                VStack(alignment: .leading, spacing: 9) {
                    LaTeXText(
                        latex: equation.equation,
                        pointSize: 22,
                        weight: .bold,
                        color: UIColor(accent)
                    )
                    Text(equation.interpretation)
                        .font(.einsteinCaption)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color.einsteinNavy, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .textSelection(.enabled)
            }
        }
    }
}

struct PaperFullTextSection: View {
    let chapters: [PaperChapter]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Label("完整論文", systemImage: "book.pages.fill")
                    .font(.einsteinTitle2.bold())
                Spacer()
                Text("\(chapters.count) 章")
                    .font(.einsteinCaption.bold().monospacedDigit())
                    .foregroundStyle(accent)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(accent.opacity(0.12), in: Capsule())
            }

            ForEach(chapters.enumerated(), id: \.element.id) { index, chapter in
                PaperChapterView(
                    chapterNumber: index + 1,
                    title: chapter.title,
                    paragraphs: chapter.paragraphs,
                    equations: chapter.equations,
                    accent: accent
                )
            }
        }
    }
}

struct PaperChapterView: View {
    let chapterNumber: Int
    let title: String
    let paragraphs: [String]
    let equations: [PaperEquation]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(chapterNumber < 10 ? "0\(chapterNumber)" : "\(chapterNumber)")
                    .font(.einsteinCaption.bold().monospacedDigit())
                    .foregroundStyle(accent)
                Text(title)
                    .font(.einsteinTitle3.bold())
            }

            ForEach(paragraphs, id: \.self) { paragraph in
                Text(paragraph)
                    .font(.einsteinBody)
                    .foregroundStyle(.primary.opacity(0.88))
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)
                    .textSelection(.enabled)
            }

            if !equations.isEmpty {
                PaperEquationsSection(equations: equations, accent: accent)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
    }
}

struct PaperConclusionSection: View {
    let conclusion: String
    let historicalImpact: String
    let accent: Color

    var body: some View {
        VStack(spacing: 12) {
            PaperTextBlock(title: "論文結論", icon: "checkmark.seal.fill", text: conclusion)
            PaperTextBlock(title: "歷史影響", icon: "clock.arrow.circlepath", text: historicalImpact)
        }
        .padding(16)
        .background(accent.opacity(0.09), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct PaperTextBlock: View {
    let title: String
    let icon: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.einsteinHeadline)
            Text(text)
                .font(.einsteinSubheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
