import SwiftUI
@preconcurrency import Splash

private let fontPath = "/System/Library/Fonts/Menlo.ttc"
private let font = Splash.Font(path: fontPath, size: 15)
private let theme = Theme.wwdc17(withFont: font)
private let format = AttributedStringOutputFormat(theme: theme)
private let highlighter = SyntaxHighlighter(format: format)

struct CodeView: View {
    let code: String
    
    init(_ code: String) {
        self.code = code
    }
    
    var body: some View {
        ScrollView([.vertical, .horizontal]) {
            Text(AttributedString(highlighter.highlight(code)))
                .padding()
        }
        .defaultScrollAnchor(.topLeading)
        .background(Color(theme.backgroundColor.cgColor))
    }
}
