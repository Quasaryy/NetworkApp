//
//  CollectionViewController.swift
//  NetworkApp
//
//  Created by Yury on 15.02.23.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let cellsInRow: CGFloat = 4
    var users: User?
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting data from remote host
        getData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBar = segue.destination as! UITabBarController
        
        if let nameVC = tabBar.viewControllers?[0] as? NameViewController {
            let index = collectionView.indexPathsForSelectedItems?.first?.item
            nameVC.result = users?.results[index!]
        }
        
        if let emailVC = tabBar.viewControllers?[1] as? EmailViewController {
            let index = collectionView.indexPathsForSelectedItems?.first?.item
            emailVC.result = users?.results[index!]
        }
        
        if let agelVC = tabBar.viewControllers?[2] as? AgeViewController {
            let index = collectionView.indexPathsForSelectedItems?.first?.item
            agelVC.result = users?.results[index!]
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Creating and casting custom cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        // Configuring the cell
        cell.configureCell(model: users, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    //
    
}

// MARK: Configure cell size
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width
        let cellSize = (availableWidth - insetForSection.left * (cellsInRow + 1)) / cellsInRow
        let size = CGSize(width: cellSize, height: cellSize)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSection
    }
}

// MARK: Getting data
extension CollectionViewController {
    private func getData() {
        guard let url = URL(string: "https://randomuser.me/api/?results=100") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.users = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
