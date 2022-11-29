//
//  main.swift
//  MyCreditManger
//
//  Created by ChangwonKim on 2022/11/10.
//

import Foundation

enum MenuType: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case addGrade = "3"
    case deleteGrade = "4"
    case viewAverage = "5"
    case exit = "X"
}
//MARK: - Start
var stInfo = Student()
var stList = StudentList(students: [stInfo])
var menuValue: String?
var inputValue: String?
var value = ""
let process = ProcessInput()

while(value != MenuType.exit.rawValue) {
   value = start()
}

//MARK: - 입력정보 분기
func start() -> String {
    print("""
          원하는 기능을 입력해 주세요
          1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X:종료
          """)
    menuValue = readLine()
    switch menuValue?.uppercased() {
    case MenuType.addStudent.rawValue:
        print("추가할 학생의 이름을 입력해주세요")
        inputValue = readLine()
        process.addStudent(inputValue ?? "")
        break
    case MenuType.deleteStudent.rawValue:
        print("삭제할 학생의 이름을 입력해주세요")
        inputValue = readLine()
        process.deleteStudent(inputValue ?? "")
        break
    case MenuType.addGrade.rawValue:
        print("""
              성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해 주세요"
              입력예) Mickey Swift A+"
              만약 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
              """)
        inputValue = readLine()
        process.addGrade(inputValue ?? "")
        break
    case MenuType.deleteGrade.rawValue:
        print("""
              성적을 삭제할 학생의 이름, 과목 이름 띄어쓰기로 구분하여 차례로 작성해주세요.
              입력예) Mickey Swift
              """)
        inputValue = readLine()
        process.deleteGrade(inputValue ?? "")
        break
    case MenuType.viewAverage.rawValue:
        print("평점을 알고 싶은 학생의 이름을 입력해 주세요")
        inputValue = readLine()
        process.viewGrade(inputValue ?? "")
        break
    case MenuType.exit.rawValue:
        print("프로그램을 종료합니다.")
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해 주세요")
    }
    return menuValue!.uppercased()
}






