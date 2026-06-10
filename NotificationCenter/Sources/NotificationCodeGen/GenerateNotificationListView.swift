import Foundation
import Hatch

public func createNotificationListViewFile() throws {
    let fileURL = projectURL
        .appendingPathComponent("NotificationList")
        .appendingPathComponent("NotificationListView.swift")
    
    let contents = code()
    try contents.write(to: fileURL, atomically: true, encoding: .utf8)
    print("Created \(fileURL.path())")
}

@StringBuilder private func code() -> String {
    let modelNames = projectSymbols()
        .compactMap { $0 as? InheritingSymbol }
        .filter { $0.inheritedTypes.contains("Notification") }
        .map { $0.name }

    #"""
    import SwiftUI

    struct NotificationCenterView: View {
        
        let items: [any Notification]
        
        var body: some View {
            List(items, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(String(describing: type(of: item)))
                        .font(.caption)
                        .fontWeight(.heavy)
                        .padding(.bottom)
    
                switch item {
    """#

    for modelName in modelNames {
        let viewName = modelName + "View"
    """
                    case let item as \(modelName):
                        \(viewName)(content: item)
    """
    }

    """
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.secondary.gradient)
                .cornerRadius(10)
            }
        }
    }

    #Preview {
        NotificationCenterView(
            items: [
    """
    for modelName in modelNames {
    """
                \(modelName).mock,
    """
    }
    """
            ]
        )
    }

    """
}

import SwiftUI

#Preview {
    CodeView(code())
}
