//
//  JCStringExtension.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

extension String {
    
    public func toDictonary() -> Dictionary<String, Any> {
        return toDictonaryNullable() ?? [String: Any]()
    }
    
    public func toDictonaryNullable() -> Dictionary<String, Any>? {
        if let data = self.data(using: .utf8),
           let dic = try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: Any] {
            return dic
        }
        return nil
    }
    
    public func toModel<T>(_ type: T.Type) -> T where T: Decodable & JCDefaultable {
        return toModelNullable(type) ?? T.defaultValue as! T
    }
    
    public func toModelNullable<T>(_ type: T.Type) -> T? where T: Decodable {
        if let m = try? JSONDecoder().decode(type, from: self.data(using: .utf8)!) {
            return m
        }
        return nil
    }
    
}

extension String: JCDefaultable {
    
    public static let defaultValue = ""
    
    public enum Zero: JCDefaultable {
        public static let defaultValue = "0"
    }
    
    public enum True: JCDefaultable {
        public static let defaultValue = "true"
    }
    
    public enum False: JCDefaultable {
        public static let defaultValue = "false"
    }
    
    public enum Null: JCDefaultable {
        public static let defaultValue = "null"
    }
    
    /// 转换成Int，默认：0
    public var intValue: Int { Int(self) ?? 0 }
    
    /// 转换成Double，默认：0.0
    public var doubleValue: Double { Double(self) ?? 0.0 }
    
    /// 转换成Bool，“true”：true；其他：false
    public var boolValue: Bool { self.lowercased() == "true" ? true : false }
        
}

extension JCDefault {
    
    public typealias Null = JCDefault<String.Null>
    public typealias Empty = JCDefault<String>
    
}
