import NotificationCodeGen
import Foundation
import Hatch

print("Enter name of a new notification model: ", terminator: "")

guard let notificationName = readLine() else {
    exit(0)
}
    
let structNames = projectSymbols()
    .compactMap { $0 as? Struct }
    .map(\.name)

if structNames.contains(notificationName) {
    print("\(notificationName) already exists")
    exit(1)
}

try createNotificationFile(notificationName)
try createNotificationListViewFile()


