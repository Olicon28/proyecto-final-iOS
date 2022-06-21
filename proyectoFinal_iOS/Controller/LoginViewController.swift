//
//  LoginViewController.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 14-06-22.
//

import UIKit
import Alamofire

enum LoginAction{
    case OK
    case Failure
}

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    var passwordIsOk : Bool = false
    var emailIsOk : Bool = false
    var email : String = ""
    var password : String = ""
    var userName : String = ""
    
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
    @IBAction func onTapLogin(_ sender: Any) {
        
        print("Entra OnTapLogin")
        
        if (emailIsOk && passwordIsOk) {
            
            guard let emailSelf = emailTextField.text else {
                return
            }
            
            guard let passwordSelf = passwordTextField.text else{
                return
            }
            
            let headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            
            let loginRequest = LoginRequest(email: emailSelf, password: passwordSelf)
            
            print("loginRequest_: " , loginRequest)
            
            
            AF.request(EndPonints.login, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default, headers: headers).response { response in
                
                print ("response:")
                debugPrint(response)
                
                if response.error != nil {
                    print("se encontró un error")
                    return
                }

                guard let data = response.data else {
                    print("sin datos")
                    return
                }
                
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    
                    print("*** resultado ***\n")
                    print("success: \(loginResponse.success ?? false)")
                    print("message: \(loginResponse.message)")
                    print("data   : \(loginResponse.data)")
                    
   
                    
                    self.userName = loginResponse.data?.user.name ?? ""
                    
                    
                    if (loginResponse.success ?? false) {
                        
                        let alert = UIAlertController(title: "Login", message: "\(self.userName), bienvenido a nuestra app", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok" , style: .default, handler: { action in
                            switch action.style{
                                case .default:
                                    self.performSegue(withIdentifier: "segueToHome", sender: nil)
                                
                                case .cancel:
                                    print("")
                                    
                                case .destructive:
                                    print("")
                                    
                                @unknown default:
                                    print("")
                                
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        let alert = UIAlertController(title: "Login", message: "No hay registro con este usuario y contraseña", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok" , style: .default, handler: { action in
                            switch action.style{
                                
                                case .default:
                                    print("")
                                
                                case .cancel:
                                    print("")
                                    
                                case .destructive:
                                    print("")
                                    
                                @unknown default:
                                    print("")
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                } catch let error {
                    
                    let alert = UIAlertController(title: "Login", message: "Ha ocurrido un error", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok" , style: .default, handler: { action in
                        switch action.style{
                            case .default:
                                print(error)
                            
                            case .cancel:
                                print("")
                                
                            case .destructive:
                                print("")
                                
                            @unknown default:
                                print("")
                            
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                   
                }
             }
            
            
            
         
        }
        
    }
    

}
