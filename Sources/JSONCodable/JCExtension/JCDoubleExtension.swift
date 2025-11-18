//
//  JCDoubleExtension.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

extension Double: JCDefaultable {
    
    public typealias True = One
    public typealias False = Zero
    
    public init(_ v: Bool) {
        let tmp: Double = v ? 1.0 : 0.0
        self.init(tmp)
    }
    
    public static let defaultValue = 0.0
        
    public enum Zero: JCDefaultable {
        public static let defaultValue = 0
    }
    
    public enum One: JCDefaultable {
        public static let defaultValue = 1
    }
    
    /// 转换成Bool，0: true; 其他：false
    public var boolValue: Bool { self <= 0.0 ? false : true }
    
    /// 转换成String
    public var stringValue: String { String(self) }
    
    public func toString(_ count: Int = 2) -> String {
        String(format: "%.\(count)f", self)
    }
    
}

extension JCDefault {
    
    public typealias DouTrue = DouOne
    public typealias DouFalse = DouZero
    
    public typealias DouOne = JCDefault<Double.One>
    public typealias DouZero = JCDefault<Double.Zero>
    
}
