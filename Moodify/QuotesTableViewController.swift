//
//  QuotesTableViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/30/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class QuotesTableViewController: UITableViewController {

    var mood: Mood = .happy
    lazy var quotes = Dictionaries.moodToQuotes[mood] ?? Dictionaries.moodToQuotes[.happy]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.quoteCellIdentifier, for: indexPath)
        if let quoteCell = cell as? OptionTableViewCell {
            quoteCell.optionLabel.text = quotes[indexPath.row]
        }
        return cell
    }
 
    private struct Storyboard {
        static let quoteCellIdentifier = "Quote Cell"
    }
}
