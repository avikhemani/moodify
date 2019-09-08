//
//  EditJournalViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 6/1/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class EditJournalViewController: UIViewController, UITextViewDelegate  {

    var previousText = "Journal Entry"
    
    @IBOutlet weak var journalTextView: UITextView! {
        didSet {
            journalTextView.text = previousText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTextView.delegate = self
        journalTextView.becomeFirstResponder()
    }

}
