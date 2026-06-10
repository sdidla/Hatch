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
                case let item as BirthdayNotification:
                    BirthdayNotificationView(content: item)
                case let item as MessageNotification:
                    MessageNotificationView(content: item)
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
            BirthdayNotification.mock,
            MessageNotification.mock,
        ]
    )
}
