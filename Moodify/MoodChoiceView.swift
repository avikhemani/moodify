//
//  MoodChoiceView.swift
//  Moodify
//
//  Created by Avi Khemani on 5/27/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class MoodChoiceView: UIView {

    var mood: Mood = .happy
    
    lazy var emojiLabel: UILabel = createLabel()
    lazy var moodLabel: UILabel = createLabel()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        addSubview(label)
        return label
    }
    
    private func resizeEmojiLabel() {
        emojiLabel.text = mood.emoji
        let fontSize = bounds.size.width * SizeRatio.emojiFontSizeToBoundsHeight
        let font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        let accessibleFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        emojiLabel.font = accessibleFont
        emojiLabel.frame.size = emojiLabel.sizeThatFits(UIView.layoutFittingCompressedSize)
        emojiLabel.frame.origin = CGPoint(x: bounds.size.width/2 - emojiLabel.frame.size.width/2, y: 0)
    }
    
    private func resizeMoodLabel() {
        moodLabel.text = mood.string
        moodLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let fontSize = bounds.size.width * SizeRatio.moodFontSizeToBoundsHeight
        let font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        let accessibleFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        moodLabel.font = accessibleFont
        moodLabel.frame.size = moodLabel.sizeThatFits(UIView.layoutFittingCompressedSize)
        moodLabel.frame.origin = CGPoint(x: bounds.size.width/2 - moodLabel.frame.size.width/2, y: emojiLabel.frame.maxY * SizeRatio.moodYRelativeToEmojiHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resizeEmojiLabel()
        resizeMoodLabel()
    }
    
}

// MARK: - Constants

extension MoodChoiceView
{
    private struct SizeRatio {
        static let emojiFontSizeToBoundsHeight: CGFloat = 0.8
        static let moodFontSizeToBoundsHeight: CGFloat = 0.18
        static let moodYRelativeToEmojiHeight: CGFloat = 0.95
    }
}


