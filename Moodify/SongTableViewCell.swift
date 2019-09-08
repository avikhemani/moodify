//
//  SongTableViewCell.swift
//  Moodify
//
//  Created by Avi Khemani on 5/29/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    
    var songImage: UIImage? {
        didSet {
            songImageView.image = songImage
        }
    }

}
