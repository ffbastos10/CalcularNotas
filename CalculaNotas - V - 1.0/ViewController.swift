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
        //TODO: Perguntar pro LUCAS
        student.grades = []
        guard let firstQuarter = Float(tfFirstQuarter.text!) else { errorFirstQuarter.isHidden = false
            return errorInputNumber(tfQuarter: tfFirstQuarter)
        }
        correctInputNumber(tfQuarter: tfFirstQuarter)
        errorFirstQuarter.isHidden = true
        student.grades.insert(firstQuarter, at: 0)
//        student.grades[0] = firstQuarter
        guard let secondQuarter = Float(tfSecondQuarter.text!) else {
            errorSecondQuarter.isHidden = false
            return errorInputNumber(tfQuarter: tfSecondQuarter)
        }
        correctInputNumber(tfQuarter: tfSecondQuarter)
        errorSecondQuarter.isHidden = true
//        student.grades[1] = secondQuarter
        student.grades.insert(secondQuarter, at: 1)
        
        guard let thirdQuarter = Float(tfThirdQuarter.text!) else {
            errorThirdQuarter.isHidden = false
            return errorInputNumber(tfQuarter: tfThirdQuarter)
        }
        correctInputNumber(tfQuarter: tfThirdQuarter)
        errorThirdQuarter.isHidden = true
        student.grades.insert(thirdQuarter, at: 2)
//        student.grades[2] = thirdQuarter
        
        if(student.hasAllGrades()){
            showResults()
        }
    }
    
    
    func showResults(){
        var result: String = ""
        var image: String = ""
        var textColor : UIColor = UIColor.init(red: 0.4, green: 0.7, blue: 0.1, alpha: 1)
        //TODO: Perguntar pro LUCAS
        switch student.finalGrade{
        case 0...5:
            result = "Reprovado"
            image = "reproved"
            textColor = UIColor.red
        case 5.1..<7:
            result = "Em exame"
            image = "retake"
            textColor = UIColor.yellow
        default:
            result = "Aprovado"
            image = "approved"
        }
        lbFinalGrade.text = String(format: "%.2f",student.finalGrade)
        lbFinalResult.textColor = textColor
        lbFinalResult.text = result
        ivFinalResult.image = UIImage(named: image)
        viFinalResult.isHidden = false
    }
    
}

