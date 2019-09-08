//
//  ImageCollectionViewCell.swift
//  Moodify
//
//  Created by Avi Khemani on 5/30/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            spinner?.stopAnimating()
            imageView.image = newValue
        }
    }
}
