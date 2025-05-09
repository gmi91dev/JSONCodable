//
//  JCBoolExtension.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

extension Bool: JCDefaultable {
    
    public init(_ v: Int) {
        let tmp: Bool = v <= 0 ? false : true
        self.init(tmp)
    }
    
    public init(_ v: Double) {
        let tmp: Bool = v <= 0.0 ? false : true
        self.init(tmp)
    }
    
    public init(_ v: String) {
        let tmp: Bool = v.lowercased() == "true" ? true : false
        self.init(tmp)
    }
    
    public static let defaultValue = true
    
    public enum True: JCDefaultable {
        public static let defaultValue = true
    }
    
    public enum False: JCDefaultable {
        public static let defaultValue = false
    }
    
    /// 转换成Int，true: 1， false: 0
    public var intValue: Int { self ? 1 : 0 }
    
    /// 转换成String
    public var stringValue: String { String(self) }
    
}

extension JCDefault {
    
    public typealias True = JCDefault<Bool.True>
    public typealias False = JCDefault<Bool.False>
        
}
