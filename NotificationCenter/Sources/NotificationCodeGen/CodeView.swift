@preconcurrency import Splash
import SwiftUI

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
        ScrollView {
            Text(AttributedString(highlighter.highlight(code)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .frame(width: 500, height: 300)
        .background(Color(theme.backgroundColor.cgColor))
    }
    
}
#Preview {
    CodeView(
        """
        print("Hello World")
        
        let path = "\(projectURL)"
        
        \(projectSymbols?.description ?? "")
        """
    )
}
