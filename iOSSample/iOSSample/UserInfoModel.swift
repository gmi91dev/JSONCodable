//
//  PersonModel.swift
//  JSONCodable
//
//  Created by gmi91 on 2024/5/26.
//

import Foundation
import JSONCodable

struct Student: JCCodeDefaultable {
    
    static var defaultValue = Student(info: Person(name: "", age: 0, gender: Person.Gender.unknown, isLocal: false, title: "", workState: Person.WorkState.defaultValue), scores: [Score.defaultValue])
    
//    @JCDefault<Person>
    var info: Person
    var scores: [Score] = [Score]()
    var parents: [Person]?
    
}

struct Score: JCCodeDefaultable {
    
    static var defaultValue = Score(title: "", point: 0.0)
    
    var title: String
    var point: Double
    
}

struct Person: JCCodable {
    
    enum Gender: String, JCCodeDefaultable {
        static var defaultValue = Gender.unknown
        case male, female, unknown
    }
    
    struct WorkState: RawRepresentable, JCCodeDefaultable {
        
        static var defaultValue = WorkState(rawValue: "")
        
        static let working = WorkState(rawValue: "1")
        static let nowork = WorkState(rawValue: "-1")
        static let underway = WorkState(rawValue: "0")
        static let unknown = WorkState(rawValue: "")
        
        let rawValue: String
        
    }
    
//    static var defaultValue = Person(name: "", age: 0, gender: Person.Gender.unknown, isLocal: false, title: "", workState: WorkState.defaultValue)
    
    @JCDefault.Null
    var name: String
    
    @JCDefault.IntZero
    var age: Int
    
    @JCDefault<Gender>
    var gender: Gender
    
    @JCDefault.False
    var isLocal: Bool
    
    @JCDefault.Empty
    var title: String
    
    @JCDefault<WorkState>
    var workState: WorkState
    
    var desc = ""
    
    var workStateDesc: String {
        switch workState.rawValue {
            case WorkState.nowork.rawValue:
                return "无业"
            case WorkState.underway.rawValue:
                return "找工作中"
            case WorkState.working.rawValue:
                return "固定工作"
            default:
                return "未知"
        }
    }
    
    var genderDesc: String {
        switch gender {
            case .male:
                return "男"
            case .female:
                return "女"
            case .unknown:
                return "未知"
        }
    }
    
    enum CodingKeys: String, CodingKey {
            case name, age, isLocal, title, workState = "work_state", gender
    }
    
}




