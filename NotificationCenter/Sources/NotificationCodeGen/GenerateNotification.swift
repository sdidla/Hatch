import Foundation

public func createNotificationFile(_ modelName: String) throws {
    let fileName = modelName + ".swift"
    let fileURL = projectURL
        .appendingPathComponent("NotificationTypes")
        .appendingPathComponent(fileName)
    
    let contents = code(modelName)
    try contents.write(to: fileURL, atomically: true, encoding: .utf8)
    print("Created \(fileURL.path())")
}

private func code(_ modelName: String) -> String {
    let viewName = modelName + "View"

    return """
    import SwiftUI

    struct \(modelName): Notification {
        let id = UUID()
    }

    struct \(viewName): View {
        
        let content: \(modelName)
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("💡 Build your notification view")
            }
        }
    }

    extension \(modelName) {
        static var mock: Self {
            \(modelName)()
        }
    }

    """
}

import SwiftUI

#Preview {
    CodeView(code("ProfileVisitNotification"))
}
