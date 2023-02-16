//
//  AgeViewController.swift
//  NetworkApp
//
//  Created by Yury on 16.02.23.
//

import UIKit

class AgeViewController: UIViewController {
    
    var result: Result!

    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageLabel.text = "\(result.dob.age) years old"
        assignImage()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
}

extension AgeViewController {
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
