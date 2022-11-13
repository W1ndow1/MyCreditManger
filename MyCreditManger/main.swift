//
//  main.swift
//  MyCreditManger
//
//  Created by ChangwonKim on 2022/11/10.
//

import Foundation

enum MenuType : String{
    case addStudent = "1"
    case deleteStudent = "2"
    case addGrade = "3"
    case deleteGrade = "4"
    case viewAverage = "5"
    case exit = "X"
}

//MARK: - Start
var stInfo = Student()  //학생정보 속성
var stList = StudentList(students: [stInfo])//학생들
let process = ProcessInput()
var value = ""
while(value != MenuType.exit.rawValue)
{
   value = process.start()
}






