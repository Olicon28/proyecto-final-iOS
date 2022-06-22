//
//  NovedadesViewController.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 21-06-22.
//

import UIKit
import AlamofireImage
import Alamofire

class NovedadesViewController: UIViewController {

    @IBOutlet weak var textoNovedadTextLabel: UITextView!
    @IBOutlet weak var actividadImage: UIImageView!
    @IBOutlet weak var nombreActividadLabel: UILabel!
    @IBOutlet weak var quieroSerParteButton: UIButton!
    @IBOutlet weak var spinnerNew: UIActivityIndicatorView!
    
    var contadorGlobal:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        consumirAPI()
        createTimer()
    }

    @IBAction func onTapQuieroSerParte(_ sender: Any) {
        alertaAviso(tituloAlerta: "FELICIDADES", mensaje: "Ya eres parte de nuestra ONG", tituloOK: "Entendido")
    }
    
    func consumirAPI(){
        
        ConsultasApi.shared.getNews()
    }
    
    func cargarValoresEnPantalla(contador:Int){
        
        nombreActividadLabel.text = NewsResponse.shared.data[contador].name
        var descripcion:String = NewsResponse.shared.data[contador].content
        //var descripcionAUX:String = String()
        
        if descripcion.range(of: "<p>") != nil
        {
            print("exist 1")
            let borrar1 = descripcion.replacingOccurrences(of: "<p>", with: "")
            let borrar2 = borrar1.replacingOccurrences(of: "</p>", with: "")
            descripcion = borrar2
        }
        if descripcion.range(of: "<strong>") != nil
        {
            print("exist 2")
            let borrar1 = descripcion.replacingOccurrences(of: "<strong>", with: "")
            let borrar2 = borrar1.replacingOccurrences(of: "</strong>", with: "")
            descripcion = borrar2
            //print(descripcion)
        }
        
        //textoNovedadTextLabel.text = NewsResponse.shared.data[contador].content
        textoNovedadTextLabel.text = descripcion
        
        let defaultURL = "https://ongapi.alkemy.org/storage/Y7is63QN4q.jpeg"
        
        cargarImagen(pURL: NewsResponse.shared.data[contador].image ?? defaultURL)
        
        print(contador)
    }
    
    func createTimer(){
        
        spinnerNew.isHidden = false
        spinnerNew.startAnimating()
        
        let timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            timer.fire()
        }
    }
    
    @objc func fireTimer() {
 
        spinnerNew.hidesWhenStopped = true
        spinnerNew.stopAnimating()
        quieroSerParteButton.isHidden = false
        actividadImage.isHidden = false

        if NewsResponse.shared.message == "News retrieved successfully" {
            
            if contadorGlobal + 1 < NewsResponse.shared.data.count {
                contadorGlobal += 1
                cargarValoresEnPantalla(contador: contadorGlobal)
            }
            else
            {
                contadorGlobal = 0
                cargarValoresEnPantalla(contador: contadorGlobal)
            }
        }
        else
        {
            print("TODO MAL")
        }
    }
    
    func resetForm(){
        
        nombreActividadLabel.text = ""
        textoNovedadTextLabel.text = ""
        spinnerNew.isHidden = true
        quieroSerParteButton.isHidden = true
        actividadImage.isHidden = true
    }
    
    func cargarImagen(pURL:String) {
        
        print("URL : \(pURL)")
        AF.request(pURL).responseImage { respon in
            //debugPrint(respon)
            
            if case .success(let image) = respon.result {
                self.actividadImage.image = image
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
