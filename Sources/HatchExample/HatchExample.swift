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

        let symbols = try SymbolParser.parse(source: source)
            .flattened()
            .compactMap { $0 as? InheritingSymbol }

        dump(symbols)

        @CodeBuilder var output: String {
            """
            let a = 10

            print("for start")
            """


            for t in symbols.map(\.name) {
            """
                print(\(t))
            """
            }

            """
            print("for done")
            end
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
                name: node.identifier.text,
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
