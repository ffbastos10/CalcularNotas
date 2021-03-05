//
//  Student.swift
//  CalculaNotas - V - 1.0
//
//  Created by Felipe Bastos on 02/03/21.
//

import Foundation


class Student {
    static let MAX_GRADE = 8
    private let _name: String
    private var _schoolGrade: Int {
        didSet{
            _schoolGrade = min(_schoolGrade, Student.MAX_GRADE)
        }
    }
    private var _resultSchoolYear : String = "Matriculado"
    var name : String{
        return _name
    }
    var schoolGrade : Int{
        return _schoolGrade
    }
    var resultSchoolYear : String {
        return _resultSchoolYear
    }
    //TODO: Perguntar para o LUCAS
    var grades: [Float] = []
    var finalGrade: Float {
        var sumGrades: Float = 0
        for grade in grades {
            sumGrades += grade
        }
        return roundDecimalPlaces(value: (sumGrades / Float(grades.count)))
    }
    
    init(name: String, schoolGrade: Int) {
        self._name = name
        self._schoolGrade = schoolGrade
    }
    
    private func roundDecimalPlaces(value: Float) -> Float {
        let finalValue = Float(round(10 * value)/10)
        return  finalValue
    }
    
    private func validGrades() -> Bool {
        let isValid = grades.filter{$0 >= 0 && $0 <= 10}
        return isValid.count == 3
    }
    
    private func resultStudent() -> String{
        switch finalGrade{
        case 0...5:
            return "Reprovado"
        case 5.1..<7:
            return "Em exame"
        default:
            return  "Aprovado"
        }
    }
    
    func hasAllGrades() -> Bool{
        return grades.count == 3 && validGrades()
    }
    
    func nextGrade(){
        _resultSchoolYear = resultStudent()
        if(_resultSchoolYear == "Aprovado" && schoolGrade == 8){
            _resultSchoolYear = "Formado"
        }
        else {_schoolGrade += 1}
    }
}
