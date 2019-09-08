//
//  MoodChoiceSelectionView.swift
//  Moodify
//
//  Created by Avi Khemani on 5/27/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class MoodChoiceSelectionView: UIView {

    var moodViews = [MoodChoiceView]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Lays the mood choices out using Grid class
        var grid = Grid(layout: Grid.Layout.aspectRatio(3/5), frame: bounds)
        grid.cellCount = moodViews.count
        for index in moodViews.indices {
            moodViews[index].frame = grid[index]!
            moodViews[index].frame.origin = moodViews[index].frame.origin
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNeedsLayout()
    }
    
    // Adds the cart to the screen
    func addMood(_ mood: MoodChoiceView) {
        moodViews.append(mood)
        addSubview(mood)
    }

}
