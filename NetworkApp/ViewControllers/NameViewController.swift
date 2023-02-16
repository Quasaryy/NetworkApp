//
//  ViewController.swift
//  NetworkApp
//
//  Created by Yury on 15.02.23.
//

import UIKit


class NameViewController: UIViewController {
    
    var result: Result!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = result.name.fullName
        assignImage()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
}

extension NameViewController {
    func assignImage() {
        guard let url = URL(string: result.picture.large) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        }.resume()
    }
    
}

