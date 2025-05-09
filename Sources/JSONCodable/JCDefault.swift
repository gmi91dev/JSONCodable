//
//  Default.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/8/4.
//

import Foundation

public protocol JCDefaultable {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct JCDefault<T> where T: JCDefaultable {
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}

extension JCDefault: Encodable {}

extension JCDefault: Decodable {
    
    public init(from decoder: any Decoder) throws {
        
        DebugPrint("[开始解析默认值字段...")
        
        let container = try decoder.singleValueContainer()
        
        var tmp: T.Value = T.defaultValue
        DebugPrint("当前字段定义类型：\(T.Value.self)")
                
        do {
            tmp = try container.decode(T.Value.self)
            DebugPrint("类型匹配成功！正常解析; \(tmp)")
        }catch {
            // 类型不匹配解析失败，尝试使用String类型来解析
            DebugPrint("类型不匹配解析失败，尝试使用Bool类型来解析")
            do {
                let boolResult = try container.decode(Bool.self)
                DebugPrint("使用Bool类型解析成功！\(boolResult)")
                
                // 转换类型
                if let tmpDouble = Double(boolResult) as? T.Value {
                    tmp = tmpDouble
                    DebugPrint("转换成Double：\(tmpDouble)")
                }else if let tmpInt = Int(boolResult) as? T.Value {
                    tmp = tmpInt
                    DebugPrint("转换成Int：\(tmpInt)")
                }else if let tmpString = String(boolResult) as? T.Value {
                    tmp = tmpString
                    DebugPrint("转换成String：\(tmpString)")
                }else {
                    DebugPrint("目标类型转换失败，使用默认值：\(T.defaultValue)")
                }
            }catch {
                // Bool类型不匹配解析失败，尝试使用Int类型来解析
                DebugPrint("Bool类型不匹配解析失败，尝试使用Int类型来解析")
                do {
                    let intResult = try container.decode(Int.self)
                    DebugPrint("使用Int类型解析成功！\(intResult)")
                    
                    // 匹配类型
                    if let tmpBool = Bool(intResult) as? T.Value {
                        tmp = tmpBool
                        DebugPrint("转换成Bool：\(tmpBool)")
                    }else if let tmpDouble = Double(intResult) as? T.Value {
                        tmp = tmpDouble
                        DebugPrint("转换成Int：\(tmpDouble)")
                    }else if let tmpString = String(intResult) as? T.Value {
                        tmp = tmpString
                        DebugPrint("转换成String：\(tmpString)")
                    }else {
                        DebugPrint("目标类型转换失败，使用默认值：\(T.defaultValue)")
                    }
                    
                }catch {
                    // Int类型不匹配解析失败，尝试使用Double类型来解析
                    DebugPrint("Int类型不匹配解析失败，尝试使用Double类型来解析")
                    do {
                        let intResult = try container.decode(Double.self)
                        DebugPrint("使用Double类型解析成功！\(intResult)")
                        
                        // 匹配类型
                        if let tmpBool = Bool(intResult) as? T.Value {
                            tmp = tmpBool
                            DebugPrint("转换成Bool：\(tmpBool)")
                        }else if let tmpInt = Int(intResult) as? T.Value {
                            tmp = tmpInt
                            DebugPrint("转换成Int：\(tmpInt)")
                        }else if let tmpString = String(intResult) as? T.Value {
                            tmp = tmpString
                            DebugPrint("转换成String：\(tmpString)")
                        }else {
                            DebugPrint("目标类型转换失败，使用默认值：\(T.defaultValue)")
                        }
                        
                    }catch {
                        // Double类型不匹配解析失败，尝试使用String类型来解析
                        DebugPrint("Double类型不匹配解析失败，尝试使用String类型来解析")
                        do {
                            let stringResult = try container.decode(String.self)
                            DebugPrint("使用String类型解析成功！\(stringResult)")
                            
                            // 匹配类型
                            if let tmpBool = Bool(stringResult) as? T.Value {
                                DebugPrint("转换成Bool：\(tmpBool)")
                                tmp = tmpBool
                            }else if let tmpInt = Int(stringResult) as? T.Value {
                                DebugPrint("转换成Int：\(tmpInt)")
                                tmp = tmpInt
                            }else if let tmpDouble = Double(stringResult), let tmpDtoInt = Int(tmpDouble) as? T.Value {
                                DebugPrint("转换成DoubleToInt：\(tmpDtoInt)")
                                tmp = tmpDtoInt
                            }else if let tmpDouble = Double(stringResult) as? T.Value {
                                DebugPrint("转换成Double：\(tmpDouble)")
                                tmp = tmpDouble
                            }else {
                                DebugPrint("目标类型转换失败，使用默认值：\(T.defaultValue)")
                            }
                            
                        }catch {
                            DebugPrint("字段解析尝试失败，使用默认值：\(T.defaultValue)")
                        }
                    }
                }
            }
            
        }
        wrappedValue = tmp
        DebugPrint("默认值字段解析结束...]")
    }
    
}
