//
//  JCEncodeExtension.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/5.
//

import Foundation

extension KeyedEncodingContainer {
    mutating func encode<T>(_ value: JCDefault<T>, forKey key: Key) throws -> AnyObject where T: JCDefaultable {
        try encodeIfPresent(value.wrappedValue, forKey: key) as AnyObject
    }
}
