//
//  MoodStatsViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 6/5/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class MoodStatsViewController: UIViewController {

    @IBOutlet weak var percentStackView: UIStackView!
    @IBOutlet weak var topLevelStackView: UIStackView!
    
    @IBAction func done(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presentationController is UIPopoverPresentationController {
            view.backgroundColor = .clear
        }
        
        let percentages = getPercentages()
        for index in percentStackView.arrangedSubviews.indices {
            if let percentLabel = percentStackView.arrangedSubviews[index] as? UILabel {
                percentLabel.text = "\(percentages[index])%"
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = topLevelStackView?.sizeThatFits(UIView.layoutFittingCompressedSize) {
            preferredContentSize = CGSize(width: fittedSize.width + Storyboard.extraSpace, height: fittedSize.height + Storyboard.extraSpace)
        }
    }
    
    private func getPercentages() -> [Float] {
        let defaults = UserDefaults.standard
        var totalMoods = 0
        for mood in Mood.allCases {
            totalMoods += defaults.integer(forKey: mood.string)
        }
        if totalMoods == 0 {
            return Array(repeating: 0.0, count: percentStackView.arrangedSubviews.count)
        } else {
            var percentages = [Float]()
            for mood in Mood.allCases {
                let numMood = defaults.integer(forKey: mood.string)
                var percentage = Float(numMood)/Float(totalMoods)
                percentage *= 100
                percentages.append(percentage)
            }
            return percentages
        }
    }
    
    private struct Storyboard {
        static let extraSpace = CGFloat(20)
    }
    
}
