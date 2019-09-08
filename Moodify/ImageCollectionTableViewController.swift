//
//  ImageCollectionTableViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/30/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class ImageCollectionTableViewController: UITableViewController {

    var mood: Mood = .happy
    lazy var imageURLStringArrays = Dictionaries.moodToImages[mood] ?? Dictionaries.moodToImages[.happy]!
    
    let sections = ["Nature", "Animals", "People", "Memes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.imageCollectionCellIdentifier, for: indexPath)
        if let imageCollectionCell = cell as? ImageCollectionTableViewCell {
            imageCollectionCell.imageURLStrings = imageURLStringArrays[indexPath.section]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Storyboard.tableCellHeight
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    private struct Storyboard {
        static let tableCellHeight = CGFloat(200)
        static let imageCollectionCellIdentifier = "Image Collection Cell"
    }


}
