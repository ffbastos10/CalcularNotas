//
//  EnrollStudent.swift
//  CalculaNotas - V - 1.0
//
//  Created by Felipe Bastos on 02/03/21.
//

import UIKit

class EnrollStudent: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfSchoolGrade: UITextField!
    @IBOutlet weak var buttonEnroll: UIButton!
    var student: Student!
    
    override func viewDidLoad() {
        buttonEnroll.layer.cornerRadius = 10
        tfFullName.layer.cornerRadius = 5
        tfSchoolGrade.layer.cornerRadius = 5
        
        tfSchoolGrade.delegate = self
        tfFullName.delegate = self
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == tfFullName) {
            return tfSchoolGrade.becomeFirstResponder()
        }
        enroller(textField)
        return textField.resignFirstResponder()
    }
    //TODO: Perguntar pro LUCAS
    func errorInput (textField : UITextField){
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func correctInput (textField : UITextField){
        textField.layer.borderWidth = 0.0
        textField.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController = segue.destination as! ViewController
        ViewController.student = student
        view.endEditing(true)
    }
    
    @IBAction func enroller(_ sender: Any) {
        //TODO: Perguntar pro LUCAS
        //Contar letras do nome
        guard let nameStudent = tfFullName.text! as String? else {
            return errorInput(textField: tfFullName)
        }
        correctInput(textField: tfFullName)
        
        guard let schoolGrade = Int(tfSchoolGrade.text!) else {
            return errorInput(textField: tfSchoolGrade)
        }
        correctInput(textField: tfSchoolGrade)
        student = Student(name: nameStudent, schoolGrade: schoolGrade)
        performSegue(withIdentifier: "EnrollToCalculate", sender: nil)
    }
    
}
