import SwiftUI
import UIKit

struct LaTeXText: UIViewRepresentable {
    let latex: String
    var pointSize: CGFloat = 22
    var weight: UIFont.Weight = .regular
    var color: UIColor = .label
    var textAlignment: NSTextAlignment = .left

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }

    func updateUIView(_ label: UILabel, context: Context) {
        label.attributedText = LaTeXRenderer.attributedString(
            from: latex,
            pointSize: pointSize,
            weight: weight,
            color: color
        )
        label.textAlignment = textAlignment
        label.accessibilityLabel = LaTeXRenderer.accessibleText(from: latex)
    }

    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UILabel, context: Context) -> CGSize? {
        let width = proposal.width ?? UIView.noIntrinsicMetric
        return uiView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
    }
}

private enum LaTeXRenderer {
    private struct Segment {
        let text: String
        let level: ScriptLevel
    }

    private enum ScriptLevel {
        case normal
        case superscript
        case lowerScript
    }

    private static let commands: [(String, String)] = [
        ("\\Longrightarrow", "⟹"), ("\\Rightarrow", "⇒"),
        ("\\partial", "∂"), ("\\nabla", "∇"), ("\\square", "□"),
        ("\\langle", "⟨"), ("\\rangle", "⟩"), ("\\approx", "≈"),
        ("\\times", "×"), ("\\cdot", "·"), ("\\pm", "±"),
        ("\\Delta", "Δ"), ("\\Gamma", "Γ"), ("\\Lambda", "Λ"),
        ("\\Phi", "Φ"), ("\\Pi", "Π"),
        ("\\alpha", "α"), ("\\beta", "β"), ("\\gamma", "γ"),
        ("\\delta", "δ"), ("\\epsilon", "ε"), ("\\zeta", "ζ"),
        ("\\eta", "η"), ("\\theta", "θ"), ("\\lambda", "λ"),
        ("\\mu", "μ"), ("\\nu", "ν"), ("\\pi", "π"),
        ("\\rho", "ρ"), ("\\sigma", "σ"), ("\\tau", "τ"),
        ("\\phi", "φ"), ("\\hbar", "ℏ"), ("\\infty", "∞"),
        ("\\ll", "≪"), ("\\perp", "⊥"), ("\\parallel", "∥"),
        ("\\prime", "′"), ("\\,", " "), ("\\quad", "  ")
    ]

    static func attributedString(
        from source: String,
        pointSize: CGFloat,
        weight: UIFont.Weight,
        color: UIColor
    ) -> NSAttributedString {
        let scaledSize = UIFontMetrics(forTextStyle: .title3).scaledValue(for: pointSize)
        let baseFont = mathFont(size: scaledSize, weight: weight)
        let output = NSMutableAttributedString()
        let normalized = normalize(source)

        for segment in parseScripts(normalized) {
            let scriptScale: CGFloat = segment.level == .normal ? 1 : 0.72
            let font = mathFont(size: scaledSize * scriptScale, weight: weight)
            let baseline: CGFloat
            switch segment.level {
            case .normal:
                baseline = 0
            case .superscript:
                baseline = scaledSize * 0.35
            case .lowerScript:
                baseline = -scaledSize * 0.18
            }

            output.append(NSAttributedString(
                string: segment.text,
                attributes: [
                    .font: font,
                    .foregroundColor: color,
                    .baselineOffset: baseline,
                    .kern: segment.level == .normal ? 0.25 : 0
                ]
            ))
        }

        output.addAttribute(.font, value: baseFont, range: NSRange(location: 0, length: 0))
        return output
    }

    static func accessibleText(from source: String) -> String {
        normalize(source)
            .replacingOccurrences(of: "^", with: " 次方 ")
            .replacingOccurrences(of: "_", with: " 下標 ")
            .replacingOccurrences(of: "{", with: "")
            .replacingOccurrences(of: "}", with: "")
    }

    private static func mathFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3)
            .withDesign(.serif)?
            .withSymbolicTraits(.traitItalic)
        let font = descriptor.map { UIFont(descriptor: $0, size: size) }
            ?? UIFont(name: "TimesNewRomanPS-ItalicMT", size: size)
            ?? UIFont.systemFont(ofSize: size)
        return UIFont.systemFont(ofSize: size, weight: weight == .bold ? .semibold : .regular)
            .withTraits(from: font)
    }

    private static func normalize(_ source: String) -> String {
        var value = source
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: "\\left", with: "")
            .replacingOccurrences(of: "\\right", with: "")
            .replacingOccurrences(of: "\\mathrm", with: "")
            .replacingOccurrences(of: "\\text", with: "")

        for (command, symbol) in commands {
            value = value.replacingOccurrences(of: command, with: symbol)
        }

        value = replaceFractions(in: value)
        value = replaceSquareRoots(in: value)

        let superscripts: [Character: Character] = [
            "⁰": "0", "¹": "1", "²": "2", "³": "3", "⁴": "4",
            "⁵": "5", "⁶": "6", "⁷": "7", "⁸": "8", "⁹": "9",
            "ᴬ": "A", "ᴮ": "B", "ᴺ": "N", "ᵀ": "T"
        ]
        let lowerScripts: [Character: Character] = [
            "₀": "0", "₁": "1", "₂": "2", "₃": "3", "₄": "4",
            "₅": "5", "₆": "6", "₇": "7", "₈": "8", "₉": "9",
            "ₛ": "s", "ₘ": "m", "ₐ": "a", "ₓ": "x"
        ]

        var converted = ""
        for character in value {
            if let replacement = superscripts[character] {
                converted += "^{" + String(replacement) + "}"
            } else if let replacement = lowerScripts[character] {
                converted += "_{" + String(replacement) + "}"
            } else {
                converted.append(character)
            }
        }
        return converted
    }

    private static func replaceFractions(in source: String) -> String {
        replaceCommand("\\frac", in: source) { numerator, denominator in
            "(" + numerator + ")⁄(" + denominator + ")"
        }
    }

    private static func replaceSquareRoots(in source: String) -> String {
        var result = source
        while let range = result.range(of: "\\sqrt{"),
              let closing = matchingBrace(in: result, openingAt: result.index(range.upperBound, offsetBy: -1)) {
            let contentStart = range.upperBound
            let content = String(result[contentStart..<closing])
            result.replaceSubrange(range.lowerBound...closing, with: "√(" + content + ")")
        }
        return result
    }

    private static func replaceCommand(
        _ command: String,
        in source: String,
        transform: (String, String) -> String
    ) -> String {
        var result = source
        while let commandRange = result.range(of: command + "{") {
            let firstOpening = result.index(commandRange.upperBound, offsetBy: -1)
            guard let firstClosing = matchingBrace(in: result, openingAt: firstOpening) else { break }
            let secondOpening = result.index(after: firstClosing)
            guard secondOpening < result.endIndex, result[secondOpening] == "{",
                  let secondClosing = matchingBrace(in: result, openingAt: secondOpening) else { break }
            let numerator = String(result[result.index(after: firstOpening)..<firstClosing])
            let denominator = String(result[result.index(after: secondOpening)..<secondClosing])
            result.replaceSubrange(commandRange.lowerBound...secondClosing, with: transform(numerator, denominator))
        }
        return result
    }

    private static func matchingBrace(in text: String, openingAt opening: String.Index) -> String.Index? {
        var depth = 0
        var index = opening
        while index < text.endIndex {
            if text[index] == "{" {
                depth += 1
            } else if text[index] == "}" {
                depth -= 1
                if depth == 0 { return index }
            }
            index = text.index(after: index)
        }
        return nil
    }

    private static func parseScripts(_ source: String) -> [Segment] {
        var segments: [Segment] = []
        var buffer = ""
        var index = source.startIndex

        func flush() {
            guard !buffer.isEmpty else { return }
            segments.append(Segment(text: buffer, level: .normal))
            buffer = ""
        }

        while index < source.endIndex {
            let marker = source[index]
            guard marker == "^" || marker == "_" else {
                buffer.append(marker)
                index = source.index(after: index)
                continue
            }

            let next = source.index(after: index)
            guard next < source.endIndex else {
                buffer.append(marker)
                break
            }

            flush()
            let level: ScriptLevel = marker == "^" ? .superscript : .lowerScript
            if source[next] == "{", let closing = matchingBrace(in: source, openingAt: next) {
                let content = String(source[source.index(after: next)..<closing])
                segments.append(Segment(text: content, level: level))
                index = source.index(after: closing)
            } else {
                segments.append(Segment(text: String(source[next]), level: level))
                index = source.index(after: next)
            }
        }
        flush()
        return segments
    }
}

private extension UIFont {
    func withTraits(from source: UIFont) -> UIFont {
        guard let combined = fontDescriptor.withSymbolicTraits(source.fontDescriptor.symbolicTraits) else {
            return self
        }
        return UIFont(descriptor: combined, size: pointSize)
    }
}
