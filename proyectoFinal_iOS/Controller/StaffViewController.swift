//
//  StaffViewController.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 22-06-22.
//

import UIKit
import Alamofire


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class StaffViewController: UIViewController {
    
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var nameMemberLabel: UILabel!
    @IBOutlet weak var roleMemberLabel: UILabel!
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupView()

    }
    

    


    
    
    
    func setupView(){
        print("Hola Members")
        
        AF.request(EndPonints.members).response { response in
        
            
            if response.error != nil {
                print("se encontró un error")
                return
            }

            guard let data = response.data else {
                print("sin datos")
                return
            }
            
            do {
                let staffResponse = try JSONDecoder().decode( StaffResponse.self, from: data )
                
                guard let selfData = staffResponse.data else{
                    return
                }
                
                if let urlImg : String = selfData[0].image{
                    print(urlImg)
                    self.memberImage.downloaded(from: urlImg)
                    self.memberImage.layer.cornerRadius = 16.0
                    self.memberImage.contentMode = .scaleAspectFill
                    
                }
                
                
                self.nameMemberLabel.text = selfData[0].name
                self.roleMemberLabel.text = String(htmlEncodedString: selfData[0].description)
                
                
//                for member in selfData {
//                    print("nombre_: ", member.name)
//                }

            } catch let error {
                
                let alert = UIAlertController(title: "Member", message: "Ha ocurrido un error", preferredStyle: .alert)
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
