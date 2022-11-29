//
//  Model.swift
//  MyCreditManger
//
//  Created by ChangwonKim on 2022/11/11.
//

import Foundation

struct StudentList {
    var students = [Student]()
}
struct Student {
    var name: String?
    var subjectAndGrade: [String:String] = [:]
}

struct Age {
    private(set) var value: Int
    init?(value: Int) {
        guard(0...200).contains(value) else {
            return nil
        }
        self.value = value
    }
}
