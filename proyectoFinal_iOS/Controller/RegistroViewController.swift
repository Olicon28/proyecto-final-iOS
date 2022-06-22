//
//  RegistroViewController.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 15-06-22.
//

import UIKit

class RegistroViewController: UIViewController {

    @IBOutlet weak var nombreYapellidoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repitePasswordTextField: UITextField!
    @IBOutlet weak var registrameButton: UIButton!
    
    @IBOutlet weak var nombreApellidoErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var pass1ErrorLabel: UILabel!
    @IBOutlet weak var pass2ErrorLabel: UILabel!
    @IBOutlet weak var spinnerIngreso: UIActivityIndicatorView!
    
    var msjeRespuestaGlobal:String = String()
    
    var nombreApellidoIsOK:Bool = false
    var passwordIsOk : Bool = false
    var RepitePasswordIsOk : Bool = false
    var emailIsOk : Bool = false
    
    var pass1:String = String()
    var pass2:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistroViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        resetForm()
    }
    
    @objc func dismissKeyboard() {
    //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
           view.endEditing(true)
       }
    
    @IBAction func onTapRegistrame(_ sender: Any) {
        
        guard let nombreYapellido = nombreYapellidoTextField.text, nombreYapellido.count > 0 else {
            return
        }
        guard let email = emailTextField.text, email.count > 0 else {
            return
        }
        guard let password1 = passwordTextField.text, password1.count > 0 else {
            return
        }
        guard let password2 = repitePasswordTextField.text, password2.count > 0 else {
            return
        }
        
        print(nombreYapellido)
        print(email)
        print(password1)
        print(password2)
        
        consumirAPI(nombre: nombreYapellido, mail: email, pass: password1)
        createTimer()
            
    }
    
    @IBAction func onTapYaTienesCuenta(_ sender: Any) {
        //self.dismiss(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func changeNombreApellido(_ sender: Any) {
        
        if let nombreApellido = nombreYapellidoTextField.text{
            if(validateNombreApellido(value: nombreApellido)){
                nombreYapellidoTextField.layer.borderWidth = 0.0
                nombreApellidoErrorLabel.isHidden = true
                nombreApellidoIsOK = true
                validateSubmit()
            }else{
                nombreYapellidoTextField.layer.borderWidth = 1.0
                let redColor = UIColor.red
                nombreYapellidoTextField.layer.borderColor = redColor.cgColor
                nombreApellidoErrorLabel.isHidden = false
                
                nombreApellidoErrorLabel.text = "* Registro Obligatorio"
                
                nombreApellidoIsOK = false
                validateSubmit()
            }
        }
        
    }
    @IBAction func changeEmail(_ sender: Any) {
        
        if let email = emailTextField.text{
            if validateEmail(value: email){
                emailTextField.layer.borderWidth = 0.0
                emailErrorLabel.isHidden = true
                emailIsOk = true
                validateSubmit()
            }else{
                emailTextField.layer.borderWidth = 1.0
                let redColor = UIColor.red
                emailTextField.layer.borderColor = redColor.cgColor
                emailErrorLabel.isHidden = false
                
                emailErrorLabel.text = "* Registro Obligatorio"
                
                emailIsOk = false
                validateSubmit()
            }
        }
    }

    @IBAction func changePassword(_ sender: Any) {
        
        if let password = passwordTextField.text{
            if(validatePassword(value: password)){
                passwordTextField.layer.borderWidth = 0.0
                pass1ErrorLabel.isHidden = true
                passwordIsOk = true
                pass1 = password
                validateSubmit()
            }else{
                passwordTextField.layer.borderWidth = 1.0
                let redColor = UIColor.red
                passwordTextField.layer.borderColor = redColor.cgColor
                pass1ErrorLabel.isHidden = false
                passwordIsOk = false
                validateSubmit()
            }
        }
    }
    @IBAction func changeRepitePassword(_ sender: Any) {
        
        if let password = repitePasswordTextField.text{
            if(validatePassword(value: password)){
                repitePasswordTextField.layer.borderWidth = 0.0
                pass2ErrorLabel.isHidden = true
                RepitePasswordIsOk = true
                pass2 = password
                validateSubmit()
            }else{
                repitePasswordTextField.layer.borderWidth = 1.0
                let redColor = UIColor.red
                repitePasswordTextField.layer.borderColor = redColor.cgColor
                pass2ErrorLabel.isHidden = false
                RepitePasswordIsOk = false
                validateSubmit()
            }
        }
    }
    
    func validatePassword(value : String) -> Bool {
        if value.isEmpty || value == "" || value.count <= 2{
            return false
        }
        return true
        
    }
    
    func validateNombreApellido(value : String) -> Bool {
        
        if value.isEmpty || value == "" || value.count <= 2 {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    func validateEmail(value : String)->Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        if predicate.evaluate(with: value){
            return true
        }
        
        return false
    }
    
    func validateSubmit() {
        
        if emailIsOk && passwordIsOk && RepitePasswordIsOk && nombreApellidoIsOK {
            if pass1 == pass2 {
                registrameButton.isEnabled = true
                registrameButton.backgroundColor = .systemRed
                pass1ErrorLabel.isHidden = true
                pass2ErrorLabel.isHidden = true
            }
            else
            {
                pass1ErrorLabel.text = "Password no coinciden"
                pass2ErrorLabel.text = "Password no coinciden"
                pass1ErrorLabel.isHidden = false
                pass2ErrorLabel.isHidden = false
                registrameButton.isEnabled = false
                registrameButton.backgroundColor = .systemGray2
            }
        }
        else
        {
            registrameButton.isEnabled = false
            registrameButton.backgroundColor = .systemGray2
        }
    }
    
    func resetForm() {
        
        nombreApellidoErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        pass1ErrorLabel.isHidden = true
        pass2ErrorLabel.isHidden = true
        registrameButton.isEnabled = false
        registrameButton.backgroundColor = .systemGray2
        spinnerIngreso.isHidden = true
    }
    
}

extension RegistroViewController {
    
    func consumirAPI(nombre:String, mail:String, pass:String) {
        
        ConsultasApi.shared.registerUser(name: nombre, email: mail, password: pass, complete: didGetUserRegister)
        
    }
    
    func didGetUserRegister(code: Int, messsage: String) {
        
            print("Callback didGetUserRegister")
            print("code    : \(code)")
            print("messsage: \(messsage)")
            
            msjeRespuestaGlobal = messsage

    }
    
    func imprimirAlertaRegistro(msj:String, cerrarPantalla:Bool) {
        let alert = UIAlertController(title: "AVISO", message: msj, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Entendido", style: .default) { _ in
            
            if cerrarPantalla {
                //self.dismiss(animated: true)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    func createTimer(){
        
        spinnerIngreso.isHidden = false
        spinnerIngreso.startAnimating()
        
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            timer.fire()
        }
    }
    
    @objc func fireTimer() {
 
        spinnerIngreso.hidesWhenStopped = true
        spinnerIngreso.stopAnimating()
        
        if msjeRespuestaGlobal == "user registered" {
            imprimirAlertaRegistro(msj: "Usuario creado correctamente", cerrarPantalla: true)
        }
        else
        {
            imprimirAlertaRegistro(msj: "Datos invalidos, usuario ya existe en los registros", cerrarPantalla: false)
            
            emailTextField.layer.borderWidth = 1.0
            let redColor1 = UIColor.red
            emailTextField.layer.borderColor = redColor1.cgColor
            
            nombreYapellidoTextField.layer.borderWidth = 1.0
            let redColor2 = UIColor.red
            nombreYapellidoTextField.layer.borderColor = redColor2.cgColor
            
            nombreApellidoErrorLabel.isHidden = false
            emailErrorLabel.isHidden = false
            nombreApellidoErrorLabel.text = "Nombre existente"
            emailErrorLabel.text = "e-mail existente"
        }
    }
    
}
