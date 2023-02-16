//
//  EmailViewController.swift
//  NetworkApp
//
//  Created by Yury on 16.02.23.
//

import UIKit

class EmailViewController: UIViewController {
    
    var result: Result!

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = result.email
        assignImage()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
}

extension EmailViewController {
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
