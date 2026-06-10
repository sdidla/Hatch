import SwiftUI

struct BirthdayNotification: Notification {
    let id = UUID()
    let personName: String
    let date: Date
}

struct BirthdayNotificationView: View {
    let content: BirthdayNotification
    
    var body: some View {
        Text(.init("🎉 Say Happy Birthday to **\(content.personName)**"))
    }
}

extension BirthdayNotification {
    static var mock: Self {
        BirthdayNotification(
            personName: "John",
            date: Date(timeIntervalSince1970: 0)
        )
    }
}
