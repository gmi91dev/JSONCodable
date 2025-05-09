//
//  JCDecodeExtension.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode<T>( _ type: JCDefault<T>.Type, forKey key: Key) throws -> JCDefault<T> where T: JCDefaultable {
        try decodeIfPresent(type, forKey: key) ?? JCDefault(wrappedValue: T.defaultValue)
    }
}

