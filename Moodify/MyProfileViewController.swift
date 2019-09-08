//
//  MyProfileViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 6/5/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var journalTableView: UITableView!
    
    var journals = Array(JournalEntry.names) 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.journalCellIdentifier, for: indexPath)
        cell.textLabel?.text = journals[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.7626725697, blue: 0.1259660514, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Storyboard.journalsHeaderName
    }
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet{
            profileImageView.image = UIImage(named: Storyboard.defaultProfileImageName)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = journals[indexPath.row]
            let alert = UIAlertController(
                title: Storyboard.deleteAlertTitle,
                message: "Are you sure you want to delete the entry for the date \(entryToDelete)? You won't be able to access it again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "No",
                style: .default
            ))
            alert.addAction(UIAlertAction(
                title: "Yes",
                style: .default,
                handler: { finished in
                    self.journals.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    JournalEntry.delete(named: entryToDelete)
            }
            ))
            present(alert, animated: true)
        }
    }
    
    private lazy var emojiList = createEmojiList()
    
    private func createEmojiList() -> [String] {
        var emojis = [String]()
        for mood in Mood.allCases {
            emojis.append(mood.emoji)
        }
        return emojis
    }
    
    var currentMood = "😊" {
        didSet {
            currentMoodLabel.text = currentMood
        }
    }
   
    @IBOutlet weak var currentMoodLabel: UILabel! {
        didSet {
            currentMoodLabel.text = currentMood
        }
    }
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBAction func dropDownClick(_ sender: UIButton) {
        dropDown.isHidden = false
    }
    
    @IBAction func reloadEntries(_ sender: UIButton) {
        journals = Array(JournalEntry.names)
        journalTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.delegate = self
        journalTableView.delegate = self
        journalTableView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentMood = emojiList[row]
        dropDown.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Storyboard.pickerHeightSize
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = emojiList[row]
        label.textAlignment = .center
        label.font = UIFont(name: Storyboard.fontName, size: Storyboard.fontSize)
        return label
    }
    
    @IBAction func importFromCameraRoll(_ sender: UIButton) {
        importPicture(withType: .photoLibrary)
    }
    
    private func importPicture(withType sourceType: UIImagePickerController.SourceType) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = sourceType
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.journalEntrySegueIdentifier {
            if let jevc = segue.destination as? JournalEntryViewController {
                if let selectedCell = sender as? UITableViewCell {
                    jevc.journalEntry = JournalEntry(named: selectedCell.textLabel?.text!)
                    selectedCell.isSelected = false
                }
            }
        }
    }
    
    private struct Storyboard {
        static let journalEntrySegueIdentifier = "Show Journal Entry"
        static let fontName = "Arial"
        static let fontSize = CGFloat(35)
        static let pickerHeightSize = CGFloat(50)
        static let deleteAlertTitle = "Delete Confirmation"
        static let defaultProfileImageName = "defaultProfile"
        static let journalsHeaderName = "Journals"
        static let journalCellIdentifier = "Journal Cell"
    }
    
}
