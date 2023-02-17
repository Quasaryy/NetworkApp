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
    var users = User(results: [])
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting data from remote host
        getData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBar = (segue.destination as? UITabBarController) else { return }
        
        if let nameVC = tabBar.viewControllers?[0] as? NameViewController {
            guard let index = collectionView.indexPathsForSelectedItems?.first?.item else { return }
            nameVC.result = users.results[index]
        }
        
        if let emailVC = tabBar.viewControllers?[1] as? EmailViewController {
            guard let index = collectionView.indexPathsForSelectedItems?.first?.item else { return }
            emailVC.result = users.results[index]
        }
        
        if let agelVC = tabBar.viewControllers?[2] as? AgeViewController {
            guard let index = collectionView.indexPathsForSelectedItems?.first?.item else { return }
            agelVC.result = users.results[index]
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.results.count
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

extension CollectionViewController {
    // MARK: Getting data
    private func getData() {
        guard let url = URL(string: "https://randomuser.me/api/?results=100") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.alert(title: "Something wrong", message: error.localizedDescription)
                }
                return
            }
            
            if let response = response {
                print(response)
            }
            
            guard let remtoteData = data else { return }
            do {
                self.users = try JSONDecoder().decode(User.self, from: remtoteData)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.alert(title: "Remote data decoding error", message: "We are working on fixing the bug, please try again later.")
                }
            }
        }.resume()
    }
    
    // MARK: Alert controller
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(buttonOK)
        present(alert, animated: true)
    }
    
}
