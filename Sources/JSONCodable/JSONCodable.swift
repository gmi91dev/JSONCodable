// The Swift Programming Language
// https://docs.swift.org/swift-book

public typealias JCCodable = Codable & JCJSONable
public typealias JCCodeDefaultable = JCCodable & JCDefaultable

let DebugFlag = true

func DebugPrint(_ item: @autoclosure () -> Any) {
    if DebugFlag {
        #if DEBUG
        print(item())
        #endif
    }
}
