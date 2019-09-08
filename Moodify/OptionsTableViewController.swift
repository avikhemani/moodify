//
//  OptionsTableViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/28/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    
    var options = Options()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return options.optionList.count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.descriptionCellIdentifier, for: indexPath)
            if let descriptionCell = cell as? DescriptionTableViewCell {
                descriptionCell.moodLabel.text = "\(options.mood.string) " + "\(options.mood.emoji)"
                descriptionCell.moodStrategyLabel.text = Dictionaries.moodToStrategy[options.mood]
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.optionCellIdentifier, for: indexPath)
            if let optionCell = cell as? OptionTableViewCell {
                optionCell.optionLabel.text = options.optionList[indexPath.row]
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Storyboard.descriptionCellHeight
        } else {
            return Storyboard.optionCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return Storyboard.optionsHeaderName
        } else {
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        let selectedOption = options.optionList[indexPath.row]
        let segueIdentifier = selectedOption + " Segue"
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.websiteSegueIdentifier {
            if let wvc = segue.destination as? WebsiteViewController {
                wvc.urlString = Dictionaries.urlStringDictionary[options.mood] ?? Dictionaries.urlStringDictionary[.happy]!
            }
        } else if segue.identifier == Storyboard.quotesSegueIdentifier || segue.identifier == Storyboard.musicSegueIdentifier || segue.identifier == Storyboard.videosSegueIdentifier {
            if let mvc = segue.destination as? MusicViewController {
                mvc.mood = options.mood
            }
        }
    }
    
    private struct Storyboard {
        static let quotesSegueIdentifier = "Quotes Segue"
        static let musicSegueIdentifier = "Music Segue"
        static let videosSegueIdentifier = "Videos Segue"
        static let websiteSegueIdentifier = "Show Website"
        static let optionsHeaderName = "Options"
        static let descriptionCellIdentifier = "Description Cell"
        static let optionCellIdentifier = "Option Cell"
        static let descriptionCellHeight = CGFloat(200)
        static let optionCellHeight = CGFloat(70)
    }
    
    
}
