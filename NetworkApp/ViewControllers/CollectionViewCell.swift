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
    func configureCell(model: User, indexPath: IndexPath) {
        // Configure the cell corner radius
        self.layer.cornerRadius = 10
        let user = model.results[indexPath.item]
        // Getting URL
        guard let url = URL(string: user.picture.medium) else { return }
        // Assigning images in URLSession
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let remoteData = data else { return }
            DispatchQueue.main.async {
                self.userImage.image = UIImage(data: remoteData)
            }
        }.resume()
    }
}
