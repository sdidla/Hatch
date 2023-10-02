import Foundation
import HatchParser
import HatchBuilder
import SwiftSyntax

@main
public struct ExampleApp {
    public static func main() throws {

        let source = """

        struct A1 {
            struct BC {
                struct C1 {}
                struct C2 {}
                struct C3 {}

            }

            struct BD {
                struct D1 {}
                struct D2 {}
            }

            struct BX {}
        }

        struct A2 {}

        enum MyEnum {}

        """

        let symbols = SymbolParser.parse(source: source)
            .flattened()
            .compactMap { $0 as? InheritingSymbol }

        dump(symbols)

        let path = "~/Repositories/myProject" as NSString
        let directoryURL = URL(fileURLWithPath: path.expandingTildeInPath)

        let allSymbols = try FileManager.default
            .enumerator(at: directoryURL, includingPropertiesForKeys: nil)?
            .compactMap { $0 as? URL }
            .filter { $0.hasDirectoryPath == false }
            .filter { $0.pathExtension == "swift" }
            .flatMap { try SymbolParser.parse(source: String(contentsOf: $0)) }

        dump(allSymbols)

        @StringBuilder var output: String {
            """

            let a = 10

            print("begin printing symbol names")
            """


            for t in symbols.map(\.name) {
            """
            print(\(t))
            """
            }

            """
            print("end printing symbol names")

            """
        }

        print(output)
    }
}

// MARK: - Custom Visitor

class MyProjectVisitor: SymbolParser {

    override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        startScope()
    }
    
    override func visitPost(_ node: StructDeclSyntax) {
        guard let genericWhereClause = node.genericWhereClause else {
            super.visitPost(node)
            return
        }

        endScopeAndAddSymbol { children in
            MySpecialStruct(
                name: node.name.text,
                children: children,
                genericWhereClause: genericWhereClause.description
            )
        }
    }
}

struct MySpecialStruct: Symbol {
    let name: String
    let children: [Symbol]
    let genericWhereClause: String
}

// MARK: - FileManager convenience

extension FileManager {
    public func filesInDirectory(_ directoryURL: URL) -> [URL] {
        guard let enumerator = enumerator(at: directoryURL, includingPropertiesForKeys: []) else {
            return []
        }

        return enumerator
            .compactMap { $0 as? URL }
            .filter { $0.hasDirectoryPath == false }
    }
}
