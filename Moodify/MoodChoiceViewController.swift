//
//  MoodChoiceViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/27/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit
import UserNotifications

class MoodChoiceViewController: UIViewController {

    @IBOutlet weak var moodChoiceSelectionView: MoodChoiceSelectionView!
    
    var viewToRemove: MoodChoiceView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        { (didAllow, error) in }
        setUpChoices()
    }
    
    private func setUpChoices() {
        for mood in Mood.allCases {
            let moodView = MoodChoiceView()
            moodView.mood = mood
            moodView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MoodChoiceViewController.selectMood(_:))))
            moodChoiceSelectionView.addMood(moodView)
        }
    }
    
    @IBAction func selectMood(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let moodView = recognizer.view as? MoodChoiceView {
                let selectedMood = moodView.mood
                let defaults = UserDefaults.standard
                defaults.set(defaults.integer(forKey: selectedMood.string) + 1, forKey: selectedMood.string)
                createNotification(for: selectedMood)
                animateCardAndSegue(moodView)
            }
        default:
            break
        }
    }
    
    // Citation for location Notification: https://www.youtube.com/watch?v=JuqQUP0pnZY
    private func createNotification(for mood: Mood) {
        let content = UNMutableNotificationContent()
        content.title = Storyboard.notificationTitle
        content.body = "Come back to Moodify to view the many options for being \(mood)!!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Storyboard.notificationWaitTimeSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: Storyboard.notificationIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func animateCardAndSegue(_ animatedView: MoodChoiceView) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.6,
            delay: 0,
            options: .transitionCrossDissolve,
            animations: {
                for moodView in self.moodChoiceSelectionView.moodViews {
                    if moodView != animatedView {
                        moodView.alpha = 0.0
                    }
                }
                animatedView.moodLabel.alpha = 0.0
                animatedView.center.x = self.moodChoiceSelectionView.frame.size.width/2
                animatedView.center.y = self.moodChoiceSelectionView.frame.size.height/2
                
            },
            completion: { position in
                self.performSegue(withIdentifier: Storyboard.chooseMoodSegue, sender: animatedView)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.chooseMoodSegue {
            if let otvc = segue.destination.contents as? OptionsTableViewController {
                if let selectedView = sender as? MoodChoiceView {
                    otvc.options.mood = selectedView.mood
                    for moodView in moodChoiceSelectionView.moodViews {
                        if moodView != selectedView {
                            moodView.removeFromSuperview()
                        }
                    }
                    viewToRemove = selectedView
                    moodChoiceSelectionView.moodViews.removeAll()
                }
            }
        }
    }
    
    @IBAction private func goBackHome(bySegue: UIStoryboardSegue) {
        viewToRemove?.removeFromSuperview()
        viewToRemove = nil
        setUpChoices()
    }
    
//    private func resetDefaults() {
//        let defaults = UserDefaults.standard
//        for keyValue in defaults.dictionaryRepresentation() {
//            defaults.removeObject(forKey: keyValue.key)
//        }
//    }
    
    private struct Storyboard {
        static let chooseMoodSegue = "Choose Mood"
        static let notificationTitle = "Check out more options!"
        static let notificationIdentifier = "reminderNotification"
        static let notificationWaitTimeSeconds = 180.0
    }
}
