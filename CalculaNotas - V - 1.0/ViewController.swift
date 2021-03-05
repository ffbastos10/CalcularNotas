//
//  ViewController.swift
//  CalculaNotas - V - 1.0
//
//  Created by Felipe Bastos on 28/02/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viFinalResult: UIView!
    @IBOutlet weak var tfFirstQuarter: UITextField!
    @IBOutlet weak var tfSecondQuarter: UITextField!
    @IBOutlet weak var tfThirdQuarter: UITextField!
    @IBOutlet weak var errorFirstQuarter: UILabel!
    @IBOutlet weak var errorSecondQuarter: UILabel!
    @IBOutlet weak var errorThirdQuarter: UILabel!
    @IBOutlet weak var lbFinalGrade: UILabel!
    @IBOutlet weak var lbFinalResult: UILabel!
    @IBOutlet weak var buttonCalculate: UIButton!
    @IBOutlet weak var ivFinalResult: UIImageView!
    
    var student: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCalculate.layer.cornerRadius = 10
        tfFirstQuarter.layer.cornerRadius = 5
        tfSecondQuarter.layer.cornerRadius = 5
        tfThirdQuarter.layer.cornerRadius = 5
        
        tfFirstQuarter.delegate = self
        tfSecondQuarter.delegate = self
        tfThirdQuarter.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == tfFirstQuarter) {
            return tfSecondQuarter.becomeFirstResponder()
        }
        else if(textField == tfSecondQuarter){
            return tfThirdQuarter.becomeFirstResponder()
        }
        calculateGrade(textField)
        return textField.resignFirstResponder()
    }
    
    func errorInputNumber (tfQuarter : UITextField){
        tfQuarter.layer.borderWidth = 1.0
        tfQuarter.layer.borderColor = UIColor.red.cgColor
    }
    
    func correctInputNumber (tfQuarter : UITextField){
        tfQuarter.layer.borderWidth = 0.0
        tfQuarter.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    @IBAction func calculateGrade(_ sender: Any) {
        student.grades.removeAll()
        guard let firstQuarter = Float(tfFirstQuarter.text!) else { errorFirstQuarter.isHidden = false
            return errorInputNumber(tfQuarter: tfFirstQuarter)
        }
        correctInputNumber(tfQuarter: tfFirstQuarter)
        errorFirstQuarter.isHidden = true
        student.grades.insert(firstQuarter, at: 0)
        guard let secondQuarter = Float(tfSecondQuarter.text!) else {
            errorSecondQuarter.isHidden = false
            return errorInputNumber(tfQuarter: tfSecondQuarter)
        }
        correctInputNumber(tfQuarter: tfSecondQuarter)
        errorSecondQuarter.isHidden = true
        student.grades.insert(secondQuarter, at: 1)
        
        guard let thirdQuarter = Float(tfThirdQuarter.text!) else {
            errorThirdQuarter.isHidden = false
            return errorInputNumber(tfQuarter: tfThirdQuarter)
        }
        correctInputNumber(tfQuarter: tfThirdQuarter)
        errorThirdQuarter.isHidden = true
        student.grades.insert(thirdQuarter, at: 2)
        
        if(student.hasAllGrades()){
            student.nextGrade()
            showResults()
        }
    }
    
    
    func showResults(){
        var image: String = ""
        var textColor : UIColor = UIColor.init(red: 0.4, green: 0.7, blue: 0.1, alpha: 1)
        switch student.resultSchoolYear{
        case "Reprovado":
            image = "reproved"
            textColor = UIColor.red
        case "Em exame":
            image = "retake"
            textColor = UIColor.yellow
        case "Formado":
            image = "graduate"
            textColor = UIColor.black
        default:
            image = "approved"
        }
        lbFinalGrade.text = String(format: "%.2f",student.finalGrade)
        lbFinalResult.textColor = textColor
        if(student.resultSchoolYear == "Aprovado"){
            lbFinalResult.text = "O Aluno \(student.name) está \(student.resultSchoolYear) para a \(student.schoolGrade) série"
        }
        else{
            lbFinalResult.text = "O Aluno \(student.name) está \(student.resultSchoolYear) "
        }
        ivFinalResult.image = UIImage(named: image)
        viFinalResult.isHidden = false
    }
    
}

