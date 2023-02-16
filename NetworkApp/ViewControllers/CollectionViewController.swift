//
//  CollectionViewController.swift
//  NetworkApp
//
//  Created by Yury on 15.02.23.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var users: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return users?.results.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.layer.cornerRadius = 10
        let user = users?.results[indexPath.item]
        let url = URL(string: user?.picture.medium ?? "https://randomuser.me/api/portraits/med/men/14.jpg")
        
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            DispatchQueue.main.async {
                cell.userImage.image = UIImage(data: data!)
            }
        }.resume()
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    //

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width
        let cellSize = (availableWidth - 10 * (4 + 1)) / 4

        let size = CGSize(width: cellSize, height: cellSize)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CollectionViewController {
    func getData() {
        if let url = URL(string: "https://randomuser.me/api/?results=100") {
            
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
}
