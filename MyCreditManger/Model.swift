//
//  Model.swift
//  MyCreditManger
//
//  Created by ChangwonKim on 2022/11/11.
//

import Foundation

struct StudentList{
    var students = [Student]()
}
struct Student{
    var name: String?
    var subjectAndGrade: [String:String] = [:]
    var subject: [String] = []
    var grade : [Double] = []
    var average : Double? {
        get{
            if(grade.count > 0){
                return grade.reduce(0, +) / Double(grade.count)
            }
            else{
                return 0.0
            }
        }
    }
}
