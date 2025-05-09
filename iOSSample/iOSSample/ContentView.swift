//
//  ContentView.swift
//  iOSSample
//
//  Created by gmi91 on 2025/5/9.
//

import SwiftUI
import JSONCodable

struct ContentView: View {
    
    @ObservedObject
    private var vm = ViewModel()
        
    var body: some View {
        VStack(spacing: 6) {
            
            Button {
                vm.getStudentInfo()
            } label: {
                Text("刷新")
            }
            .padding(.bottom, 20)
            
            Text("姓名：" + vm.student.info.name)
            Text("年龄：" + vm.student.info.age.stringValue)
            Text("性别：" + vm.student.info.genderDesc)
            HStack(spacing: 4) {
                Image(systemName: vm.student.info.isLocal ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(vm.student.info.isLocal ? .blue : .gray)
                Text("本地人")
            }
            
            Rectangle()
                .frame(height: 20)
                .foregroundColor(.clear)
            
            Text("Scores:")
                .font(.system(.title2))
            
            LazyVStack {
                ForEach(vm.student.scores, id: \.title) { item in
                    HStack(spacing: 0) {
                        Text(item.title)
                        Text(": " + item.point.toString(1))
                    }
                }
            }
            
            Text("Parents:")
                .font(.system(.title2))
            
            if let tmp = vm.student.parents {
                LazyVStack {
                    ForEach(tmp, id: \.title) { item in
                        HStack(spacing: 0) {
                            Text(item.title)
                            Text(": " + item.name)
                            Text(", " + item.age.stringValue)
                            Text(", " + item.workStateDesc)
                        }
                    }
                }
            }

        }
        .font(.system(size: 16))
        .padding()
    }
    
    
    
}

#Preview {
    ContentView()
}

class ViewModel: ObservableObject {
    
    @Published
    var student: Student
    
    init() {
        self.student = Student.defaultValue
    }
    
    init(_ student: Student) {
        self.student = student
    }
    
    func getStudentInfo() {
        var tmp = Student.defaultValue
        let mData = #"{"info": {"name": "李小四","gender": "male", "age": 15, "isLocal": true}, "scores": [{"title": "语文", "point": 30.8}, {"title": "数学", "point": 90}], "parents": [{"title": "爸爸", "name": "李四", "age": 35, "isLocal": true, "work_state": "1"}, {"title": "妈妈", "name": "王桂花", "age": 32, "isLocal": false, "work_state": "-1"}]}"#
        do {
            let m = try JSONDecoder().decode(Student.self, from: mData.data(using: .utf8)!)
            tmp = m
        }catch {
            print("\(error.localizedDescription)")
        }
        student = tmp
    }
    
}
