//
//  HomeViewController.swift
//  proyectoFinal_iOS
//
//  Created by teresa varas on 17-06-22.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func organizationClient(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloadOrganizationImage(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        organizationClient(from: url, contentMode: mode)
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeText: UITextView!
    @IBOutlet weak var userNameLabel : UILabel!

    override func viewDidLoad() {       
        
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        print("setup Organization")
        
        AF.request(EndPonints.organization).response { response in
        
            if response.error != nil {
                print("error at Organization")
                return
            }

            guard let data = response.data else {
                print("Organization not found")
                return
            }
            
            do {
                let organizationResponse = try JSONDecoder().decode( OrganizationResponse.self, from: data )
                
                guard let selfData = organizationResponse.data else{
                    return
                }
                
               /* if let urlImg : String = selfData.logo {
                    print(urlImg)
                    self.homeImage.downloadOrganizationImage(from: urlImg)
                    self.homeImage.layer.cornerRadius = 16.0
                    self.homeImage.contentMode = .scaleAspectFill
                }*/
                
                self.welcome.text =
                selfData.welcome_text
                
                self.homeText.text = String(htmlEncodedString: selfData.long_description)

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
