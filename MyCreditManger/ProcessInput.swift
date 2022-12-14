//
//  CheckInput.swift
//  MyCreditManger
//
//  Created by ChangwonKim on 2022/11/10.
//

import Foundation

class ProcessInput {
    let gradeToPoint:[String : Double] = ["A+" : 4.5, "A" : 4.0,
                                         "B+" : 3.5, "B" : 3.0,
                                         "C+" : 2.5, "C" : 2.0,
                                         "D+" : 1.5, "D" : 1,
                                         "F" : 0]

    //MARK: - 입력정보 처리
    func addStudent(_ name: String?) {
        guard let name = name else {
            return print("입력이 잘못되었습니다.") }
        guard !stList.students.contains(where: { $0.name == name }) else {
            return print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.") }
        stInfo.name = name
        stList.students.append(stInfo)
        print("\(String(describing: stInfo.name!)) 학생을 추가 했습니다.")
    }
    
    func deleteStudent(_ name: String) {
        guard let index = stList.students.firstIndex(where: { $0.name == name }) else {
            return print("\(name) 학생을 찾지 못했습니다.") }
        stList.students.remove(at: index)
        print("\(name) 학생을 삭제 하였습니다.")
    }
    
    func addGrade(_ value: String) {
        let input: [String] = value.components(separatedBy: " ")
        guard input.count == 3 && gradeToPoint.contains(where: { $0.key == input[2].uppercased() }) else {
            return print("입력이 잘못되었습니다. 다시 확인해주세요") }
        guard let index = stList.students.firstIndex(where: { $0.name == input[0] }) else {
            return print("입력이 잘못되었습니다. 다시 확인해주세요.") }
        stList.students[index].subjectAndGrade.updateValue(input[2], forKey: input[1])
        print("\(input[0]) 학생의 \(input[1]) 과목이 \(input[2])로 추가(변경)되었습니다.")
    }
    
    func deleteGrade(_ value: String) {
        let input: [String] = value.components(separatedBy: " ")
        guard input.count == 2 else {
            return print("입력이 잘못되었습니다. 다시 확인해주세요.") }
        guard let index = stList.students.firstIndex(where: { $0.name == input[0] }) else {
            return print("\(input[0]) 학생을 찾지 못했습니다.") }
        stList.students[index].subjectAndGrade.removeValue(forKey: input[1])
        print("\(input[0]) 학생의 \(input[1]) 과목의 성적이 삭제되었습니다.")
    }
    
    func viewGrade(_ name: String?) {
        guard let name = name else {
            return print("입력이 잘못되었습니다. 다시 확인해 주세요") }
        guard let index = stList.students.firstIndex(where: { $0.name == name }) else {
            return print("\(name) 학생을 찾지 못했습니다.") }
        
        let gradeValue = stList.students[index].subjectAndGrade
        let sumPoint = gradeValue.map( { gradeToPoint[$0.value] ?? 0.0 }).reduce(0, +)
        print(gradeValue.map( {"\($0.key): \($0.value)"} ))
        print("평점 \(sumPoint == 0.0 ? "0.0" : String(format: "%.2f", sumPoint / Double(gradeValue.count)))")
    }
}
