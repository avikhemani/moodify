//
//  JournalEntryViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 6/6/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class JournalEntryViewController: UIViewController {

    var journalEntry: JournalEntry?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var journalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = journalEntry?.date
        journalLabel.text = journalEntry?.entry
    }
}
