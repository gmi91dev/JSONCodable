//
//  JCIntExtension.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

extension Int: JCDefaultable {
    
    public typealias True = One
    public typealias False = Zero
    
    public init(_ v: Bool) {
        let tmp: Int = v ? 1 : 0
        self.init(tmp)
    }
    
    public static let defaultValue = 0
    
    public enum Zero: JCDefaultable {
        public static let defaultValue = 0
    }
    
    public enum One: JCDefaultable {
        public static let defaultValue = 1
    }
    
    /// 转换成Bool，0: true; 其他：false
    public var boolValue: Bool { self <= 0 ? false : true }
    
    /// 转换成String
    public var stringValue: String { String(self) }
    
}

extension JCDefault {
    
    public typealias IntTrue = IntOne
    public typealias IntFalse = IntZero
        
    public typealias IntOne = JCDefault<Int.One>
    public typealias IntZero = JCDefault<Int.Zero>
    
}
