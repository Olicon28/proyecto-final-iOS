//
//  TestimonioViewController.swift
//  proyectoFinal_iOS
//
//  Created by training on 22-06-22.
//

import UIKit
import Alamofire
import AlamofireImage

class TestimonioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var TablaTestimonio: UITableView!
    @IBOutlet weak var spinnerTestimonio: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TablaTestimonio.dataSource=self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ConsultarDatosApi()
        createTimer()
        TablaTestimonio.isHidden = true
    }
    
    func ConsultarDatosApi (){
        ConsumirAPITestimonio.shared.getTestimonio()
    }

    func createTimer (){
        
        spinnerTestimonio.isHidden = false
        spinnerTestimonio.startAnimating()
        
        let timer=Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(firedTimer), userInfo:nil, repeats: false)
    
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            
            timer.fire()
        }
    
    }
    
    @objc func firedTimer(){
        
        spinnerTestimonio.hidesWhenStopped = true
        spinnerTestimonio.stopAnimating()
        TablaTestimonio.isHidden = false

        
        if ResponseTestimonials.shared.success {
            ResponseTestimonials.shared.data.forEach { datos in
                TablaTestimonio.reloadData()
                
            }
        }
        
        else
        {
            print("No hay datos")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResponseTestimonials.shared.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdentificadorTabla",for: indexPath) as! TestimonioTableViewCell
        
        let url=ResponseTestimonials.shared.data[indexPath.row].image
        cell.ContactoNombre.text = ResponseTestimonials.shared.data[indexPath.row].name
        cell.DescripcionContacto.text = String(htmlEncodedString: ResponseTestimonials.shared.data[indexPath.row].description)
        
        //print(ResponseTestimonials.shared.data[indexPath.row].name)
        
        AF.request(url).responseImage {
            
            respuesta in
            if case .success(let image)=respuesta.result {
                
                cell.ImagenContacto.image=image
                cell.ImagenContacto.contentMode = .scaleAspectFit
                cell.ImagenContacto.layer.cornerRadius = cell.ImagenContacto.frame.size.height / 2
                cell.ImagenContacto.clipsToBounds = true
            }
            
        }
        
        return cell
    }
}
