//
//  ImageCollectionTableViewCell.swift
//  Moodify
//
//  Created by Avi Khemani on 5/30/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class ImageCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageURLStrings = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLStrings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.imageCellIdentifier, for: indexPath)
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.image = nil
            let url = URL(string: imageURLStrings[indexPath.row])!.imageURL
            imageCell.spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url), let newImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageCell.image = newImage
                    }
                }
            }
        }
        return cell
    }
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private struct Storyboard {
        static let imageCellIdentifier = "Image Cell"
    }

}
