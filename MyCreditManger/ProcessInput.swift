//
//  CheckInput.swift
//  MyCreditManger
//
//  Created by ChangwonKim on 2022/11/10.
//

import Foundation

class ProcessInput
{
    var menuValue: String?    //메뉴입력
    var stuValue: String?    //학생정보입력
    let gradeToPoint:[String: Double] = ["A+" : 4.5, "A" : 4.0,
                                         "B+" : 3.5, "B" : 3.0,
                                         "C+" : 2.5, "C" : 2.0,
                                         "D+" : 1.5, "D" : 1,
                                         "F" : 0]
    //프로그램 시작
    func start() -> String {
        print("""
              원하는 기능을 입력해 주세요
              1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X:종료
              """)
        menuValue = readLine()
        //들어온 입력 구분하기
        switch menuValue?.uppercased() {
            //학생 추가
        case MenuType.addStudent.rawValue:
            print("추가할 학생의 이름을 입력해주세요")
            stuValue = readLine()
            addStudent(stuValue ?? "")
            break
            //학생 삭제
        case MenuType.deleteStudent.rawValue:
            print("삭제할 학생의 이름을 입력해주세요")
            stuValue = readLine()
            deleteStudent(stuValue ?? "")
            break;
            //성적추가
        case MenuType.addGrade.rawValue:
            print("""
                  성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해 주세요"
                  입력예) Mickey Swift A+"
                  만약 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
                  """)
            stuValue = readLine()
            addGrade(stuValue ?? "")
            break;
            //성적삭제
        case MenuType.deleteGrade.rawValue:
            print("""
                  성적을 삭제할 학생의 이름, 과목 이름 띄어쓰기로 구분하여 차례로 작성해주세요.
                  입력예) Mickey Swift
                  """)
            stuValue = readLine()
            deleteGrade(stuValue ?? "")
            break
            //평점보기
        case MenuType.viewAverage.rawValue:
            print("평점을 알고 싶은 학생의 이름을 입력해 주세요")
            stuValue = readLine()
            viewGrade(stuValue ?? "")
            break;
        case MenuType.exit.rawValue:
            print("프로그램을 종료합니다.")
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해 주세요")
        }
        return menuValue!.uppercased()
    }

    //MARK: - 학생추가
    func addStudent(_ name: String){
        //입력 값이 올바른지 확인
        if(Int(name) != nil){
            print("입력이 잘못되었습니다.")
        }
        //중복확인
        if(stList.students.contains(where: {$0.name == name})){
            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
        else{
            stInfo.name = name
            stList.students.append(stInfo)
            print("\(String(describing: stInfo.name!)) 학생을 추가 했습니다.")
        }
    }
    //MARK: - 학생삭제
    func deleteStudent(_ name: String){
        //입력된 학생 있는지 확인 하고 삭제
        if let index = stList.students.firstIndex(where: {$0.name == name}){
            stList.students.remove(at: index)
            print("\(name) 학생을 삭제하였습니다.")
        }
        else{
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    //MARK: - 성적추가
    func addGrade(_ value: String) -> Void {
        let temp: [String] = value.components(separatedBy: " ")//입력된값 확인
        //이름 과목 성적순이어야 하고 성적이 올바른지 확인해야함.
        if(temp.count == 3 && gradeToPoint.contains(where: {$0.key == temp[2].uppercased()})){
            //해당하는 학생이 있는 경우 성적 추가하기 이때 기존정보가 있다면 수정하기
            if let stuIndex = stList.students.firstIndex(where: {$0.name == temp[0]}){
                //과목이 있는 경우 점수 덮어 쓰고 없으면 새로 입력
                stList.students[stuIndex].subjectAndGrade.updateValue(temp[2], forKey: temp[1])
                print("\(temp[0]) 학생의 \(temp[1]) 과목이 \(temp[2])로 추가(변경)되었습니다.")
            }
            else{
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
        else{
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    //MARK: - 성적삭제
    func deleteGrade(_ value: String) -> Void {
        //(1)입력값이 올바른지 확인,(2)학생이 있는지 확인, (3)삭제할 성적이 없는 경우
        let temp: [String] = value.components(separatedBy: " ")
        if temp.count == 2{
            if let stuIndex = stList.students.firstIndex(where: {$0.name == temp[0]}){
                stList.students[stuIndex].subjectAndGrade.removeValue(forKey: temp[1])
                print("\(temp[0]) 학생의 \(temp[1]) 과목의 성적이 삭제되었습니다.")
            }
            else{
                print("\(temp[0]) 학생을 찾지 못했습니다.")
            }
        }
        else
        {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    //MARK: - 평점보기
    func viewGrade(_ name: String) -> Void{
        //이름을 입력 받으면 그걸 가지고 저장되어 있는 자료를 찾아 보여주기
        //(1)입력이 올바른지, (2)입력된 학생이 있는지 확인, (3)확인 후 점수 보여주기
        if !name.isEmpty || Int(name) == nil {
            if let stuIndex = stList.students.firstIndex(where: {$0.name == name}){
                var sum: Double = 0.0
                for gradeDic in stList.students[stuIndex].subjectAndGrade{
                    sum += Double(gradeToPoint[gradeDic.value] ?? 0.0)
                    print("\(gradeDic.key): \(gradeDic.value)")
                }
                print("평점: \(sum == 0 ? 0.0 : sum / Double(stList.students[stuIndex].subjectAndGrade.count))")
            }
            else{
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
        else{
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
}
