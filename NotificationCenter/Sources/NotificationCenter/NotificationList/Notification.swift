import Foundation

protocol Notification {
    var id: UUID { get }
    var type: NotificationType { get }
}

enum NotificationType {
    case birthday
    case message
}

extension Notification {
    var description: String {
        switch type {
        case .birthday:
            "Birthday Notification"
        case .message:
            "Message Notification"
        }
    }
}
