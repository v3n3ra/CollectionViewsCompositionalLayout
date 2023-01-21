//
//  ViewController.swift
//  CollectionViewsCompositionalLayout
//
//  Created by V K on 21.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let images: [UIImage] = Array(1...11).map { UIImage(named: String($0))! }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        //item
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5),
                                                  height: .fractionalHeight(1),
                                                  spacing: 1)
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                      height: .fractionalHeight(1),
                                                      spacing: 1)
        
        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                            width: .fractionalWidth(0.5),
                                                            height: .fractionalHeight(1),
                                                            item: fullItem,
                                                            count: 2)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1,
                                                     leading: 1,
                                                     bottom: 1,
                                                     trailing: 1)
        
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                      height: .fractionalHeight(0.4),
                                                      spacing: 1)
        //group
        let horizontalGroup = CompositionalLayout.createGroup(alignment: .horizontal,
                                                              width: .fractionalWidth(1),
                                                              height: .fractionalHeight(0.6),
                                                              items: [item, verticalGroup])
        
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                        width: .fractionalWidth(1),
                                                        height: .fractionalHeight(0.5),
                                                        items: [mainItem, horizontalGroup])
        //section
        let section = NSCollectionLayoutSection(group: mainGroup)
        //return
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.setup(image: images[indexPath.row])
        return cell
    }
    
    
}

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    
    func setup(image: UIImage) {
        cellImageView.image = image
    }
}
