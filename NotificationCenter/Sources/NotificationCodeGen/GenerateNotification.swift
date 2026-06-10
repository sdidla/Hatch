import Foundation
import Hatch

public func createNotificationFile(_ notificationName: String) throws {
    let fileName = notificationName + "Notification.swift"
    let fileURL = projectURL
        .appendingPathComponent("NotificationTypes")
        .appendingPathComponent(fileName)
    
    let contents = code(notificationName)
    try contents.write(to: fileURL, atomically: true, encoding: .utf8)
    print("Created \(fileURL.path())")
}

private func code(_ name: String) -> String {
    let modelName = name + "Notification"
    let viewName = name + "NotificationView"

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
    CodeView(code("ProfileVisit"))
}
