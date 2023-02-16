//
//  CollectionViewCell.swift
//  NetworkApp
//
//  Created by Yury on 15.02.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var userImage: UIImageView!
    
}

extension CollectionViewCell {
    func configureCell(model: User?, indexPath: IndexPath) {
        // Configure the cell corner radius
        self.layer.cornerRadius = 10
        let user = model?.results[indexPath.item]
        // Getting URL
        let url = URL(string: user?.picture.medium ?? "https://randomuser.me/api/portraits/med/men/14.jpg")
        // Assigning images in URLSession
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            DispatchQueue.main.async {
                self.userImage.image = UIImage(data: data!)
            }
        }.resume()
    }
}
