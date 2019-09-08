//
//  DatePickerViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/31/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presentationController is UIPopoverPresentationController {
            view.backgroundColor = .clear
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = stackView?.sizeThatFits(UIView.layoutFittingCompressedSize) {
            preferredContentSize = fittedSize
        }
    }
}
