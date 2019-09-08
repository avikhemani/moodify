//
//  VideoTableViewCell.swift
//  Moodify
//
//  Created by Avi Khemani on 5/30/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var thumbnail: UIImage? {
        didSet {
            thumbnailImageView.image = thumbnail
            spinner?.stopAnimating()
        }
    }
}
