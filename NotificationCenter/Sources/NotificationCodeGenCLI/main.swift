import NotificationCodeGen
import Foundation
import Hatch

dump(projectSymbols())

print("Enter name of your notification type: ", terminator: "")

if let notificationName = readLine() {
    try createNotificationFile(notificationName)
    try createNotificationListViewFile()
}


