import Foundation

import Foundation
import SwiftUI

class MyClass {
    let x: MyEnum = .a
}

class MySubClass: MyClass {

}

enum MyEnum {
    case a
    case b
    case c
}

protocol MyProtocol {
    func foo()
}

protocol ProtocolA {}
protocol ProtocolB {}

typealias ProctocolC = ProtocolA & ProtocolB

struct MyStruct {
    let p: String
    let q: Int

    enum NestedEnum {
        case x
        case y
        case z
    }

    typealias MyNestedProtocol = MyProtocol
}

typealias MyString = String

extension MyStruct: MyProtocol {
    func foo() {}
}

extension MyStruct.NestedEnum: MyProtocol {
    func foo() {}
}

class MyObservableObject: ObservableObject {

}
