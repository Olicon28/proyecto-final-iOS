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


class StaffViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var memberCollectionView: UICollectionView!
    
    
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var nameMemberLabel: UILabel!
    @IBOutlet weak var roleMemberLabel: UILabel!
    
    var pictureMembersCollection : [String] = []
    var memberCollection : [MemberResponse] = []
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        setupView()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createTimer()
    }

    
    func setupView(){
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
                    
                    self.memberImage.downloaded(from: urlImg)
                    self.memberImage.layer.cornerRadius = 16.0
                    self.memberImage.contentMode = .scaleAspectFill
                    
                }
                
                
                self.nameMemberLabel.text = selfData[0].name
                self.roleMemberLabel.text = String(htmlEncodedString: selfData[0].description)
                
                
                for member in selfData {
                    
                    let person = MemberResponse(id: member.id, name: member.name, image: member.image ?? "", description: member.description, facebookUrl: member.facebookUrl, linkedinUrl: member.linkedinUrl, created_at: member.created_at, updated_at: member.updated_at, deleted_at: member.deleted_at ?? nil, group_id: member.group_id ?? 0)
                    
                    self.memberCollection.append(person)
                    
                    self.pictureMembersCollection.append(person.image ?? "")
                }

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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.pictureMembersCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarruselCollectionViewCell
        
        
        cell.pictureImageView.downloaded(from: self.memberCollection[indexPath.row].image ?? "")
        
        cell.layer.cornerRadius = 6.6
        
        cell.pictureImageView.contentMode = .scaleAspectFill
        cell.nameLabel.text = memberCollection[indexPath.row].name
        cell.rolLabel.text =  String(htmlEncodedString: memberCollection[indexPath.row].description)

        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = pictureMembersCollection[indexPath.row]
        
        for member in memberCollection{
            
            if let selfMember = member.image{
                if(selfMember == picture){
                    
                        print(member)
                    self.memberImage.downloaded(from: member.image ?? "")
                    
                    self.memberImage.layer.cornerRadius = 16.0
                    self.memberImage.contentMode = .scaleAspectFill

                    self.nameMemberLabel.text = member.name
                    self.roleMemberLabel.text = String(htmlEncodedString: member.description)
                    
                    
                }
                
            }
        }
    }
    
    
    func createTimer(){
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            timer.fire()
        }
    }
    
    
    @objc func fireTimer() {
        print("ReloadData")
        memberCollectionView.reloadData()

    }
        

        
        
    @IBAction func onTapButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Staff", message: "Ya eres parte!", preferredStyle: .alert)
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
        

    
    


}
