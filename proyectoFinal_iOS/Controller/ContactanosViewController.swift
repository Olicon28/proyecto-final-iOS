//
//  ContactanosViewController.swift
//  proyectoFinal_iOS
//
//  Created by training on 20-06-22.
//

import UIKit
import Alamofire

class ContactanosViewController: UIViewController {
    
    var msjeRespuestaGlobal:String = ""
    
    @IBOutlet weak var DonarButton: UIButton!
    @IBOutlet weak var NombreApellidoTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var MensajeTextField: UITextView!
    @IBOutlet weak var EnviarMensajeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnTopDonar(_ sender: Any) {
    }
    
    @IBAction func OntopEnviarMensaje(_ sender: Any) {
        
        guard let nombreYapellido = NombreApellidoTextField.text, nombreYapellido.count > 0 else {
                return
                }
        guard let email = EmailTextField.text, email.count > 0 else {
                return
                }
        guard let mensaje = MensajeTextField.text, mensaje.count > 0 else{
            return
            }
    
        
        Contact(name: nombreYapellido, email: email, Mensaje: mensaje, complete: didGetUserRegister)
        
        alertaAviso(tituloAlerta: "Aviso Contacto", mensaje: "Su mensaje ha sido enviado exitosamente", tituloOK: "Ok")
        
        NombreApellidoTextField.text=""
        EmailTextField.text=""
        MensajeTextField.text=""
        
                }
    
    
    
    func didGetUserRegister(code: Int, messsage: String) {
                print("Callback didGetUserRegister")
                print("code    : \(code)")
                print("messsage: \(messsage)")
                msjeRespuestaGlobal = messsage
        }
    
        
    func Contact(name:String, email:String, Mensaje:String, complete:@escaping (_ code:Int, _ message:String) -> ()) {

            let pURL:String = "https://ongapi.alkemy.org/api/contacts"
            let Numberphone: String = "00000"
            let headers: HTTPHeaders = [
                "Accept": "application/json"
            ]

                
            let parameters: [String: String] = [
                "name" : name,
                "email" : email,
                "phone" : Numberphone,
                "Mensaje" : Mensaje,
            ]

            AF.request(pURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response {response in

                if response.error != nil {
                    complete(1,"se encontro un error")
                    return
                }

                guard let data = response.data else {
                    complete(2,"sin datos")
                    return
                }


                do {
                    let ContResponse = try JSONDecoder().decode(ContactResponse.self, from:data)
                    print("-------")
                    print("success: \(ContResponse.success ?? false)")
                    print("message: \(ContResponse.message)")
                    print("data   : \(ContResponse.data)")
                    print("-------")

                
                    if (ContResponse.success ?? false) {
                        complete(0,ContResponse.message)
                    }
                    else
                    {
                        complete(-1,ContResponse.message)
                    }
                }
                catch let error {
                    complete(3,"error al leer contenido \(error)")
                }
            }
        }
    func alertaAviso (tituloAlerta:String, mensaje:String, tituloOK:String)
        {
            let alert = UIAlertController(title: tituloAlerta, message: mensaje, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: tituloOK, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        }
}
