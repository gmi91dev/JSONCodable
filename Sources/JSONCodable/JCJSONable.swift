//
//  JSONable.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

public protocol JCJSONable { }
public extension JCJSONable {
    
    func toJSON() -> String where Self: Encodable {
        return toJSONNullable() ?? ""
    }
    
    func toJSONNullable() -> String? where Self: Encodable {
        do {
            let data = try JSONEncoder().encode(self)
            return String(data: data, encoding: .utf8)
        }catch {
            print("\(error.localizedDescription)")
        }
        return nil
    }
    
}
