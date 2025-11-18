//
//  JSONable.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

public protocol JCJSONable { }

extension JCJSONable {
    
    public func toJSON() -> String where Self: Encodable {
        return toJSONNullable() ?? ""
    }
    
    public func toJSONNullable() -> String? where Self: Encodable {
        do {
            let data = try JSONEncoder().encode(self)
            return String(data: data, encoding: .utf8)
        }catch {
            print("\(error.localizedDescription)")
        }
        return nil
    }
    
}

extension JCJSONable where Self: Encodable {
    
    public func toDic(_ options: JSONSerialization.ReadingOptions = [.allowFragments]) -> Dictionary<String, Any> {
        return toDicNullable(options) ?? [String: Any]()
    }
    
    public func toDicNullable(_ options: JSONSerialization.ReadingOptions = [.allowFragments]) -> Dictionary<String, Any>? {
        do {
            let data = try JSONEncoder().encode(self)
            let dic = try JSONSerialization.jsonObject(with: data, options: options)
            return dic as? Dictionary<String, Any>
        }catch {
            print(error)
        }
        return nil
    }
    
}
