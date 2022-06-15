//
//  LoginViewController.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 14-06-22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    var passwordIsOk : Bool = false
    var emailIsOk : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func emailChange(_ sender: Any) {
        if let email = emailTextField.text{
            if validateEmail(value: email){
                emailTextField.layer.borderWidth = 0.0
                errorEmailLabel.isHidden = true
                emailIsOk = true
                validateSubmit()
            }else{
                emailTextField.layer.borderWidth = 1.0
                let redColor = UIColor.red
                emailTextField.layer.borderColor = redColor.cgColor
                errorEmailLabel.isHidden = false
                emailIsOk = false
                validateSubmit()
            }
        }
        
    }
    
    @IBAction func passwordChange(_ sender: Any) {
        
        if let password = passwordTextField.text{
            if(validatePassword(value: password)){
                passwordTextField.layer.borderWidth = 0.0
                errorPasswordLabel.isHidden = true
                passwordIsOk = true
                validateSubmit()
            }else{
                passwordTextField.layer.borderWidth = 1.0
                let redColor = UIColor.red
                passwordTextField.layer.borderColor = redColor.cgColor
                errorPasswordLabel.isHidden = false
                passwordIsOk = false
                validateSubmit()
            }
        }
    }
    
    @IBAction func submitLogin(_ sender: Any) {
    }
    
    func validatePassword(value : String) -> Bool {
        if value.isEmpty || value == "" || value.count <= 2{
            return false
        }
        return true
        
    }
    
    func validateEmail(value : String)->Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        if predicate.evaluate(with: value){
            return true
        }
        
        return false
    }
    
    func validateSubmit() -> Void{
        if(emailIsOk && passwordIsOk){
            loginButton.isEnabled = true
        }else{
            loginButton.isEnabled = false
        }
    }
    
    func resetForm() -> Void{
        loginButton.isEnabled = false
        emailTextField.text = ""
        passwordTextField.text = ""
        
        errorEmailLabel.isHidden = true
        errorPasswordLabel.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
