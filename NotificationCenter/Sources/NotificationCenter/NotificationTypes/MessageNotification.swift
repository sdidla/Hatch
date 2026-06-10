import SwiftUI

struct MessageNotification: Notification {
    let id = UUID()
    let name: String
    let preview: String
    let message: String
    let date: Date
}

struct MessageNotificationView: View {
    
    let content: MessageNotification
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("📨 You received a message")
            Text(content.preview).font(.title)
        }
    }
}

extension MessageNotification {
    static var mock: Self {
        MessageNotification(
            name: "Steve",
            preview: "Hello there!",
            message: "Hello there! Wanna have coffee?",
            date: Date.now
        )
    }
}
