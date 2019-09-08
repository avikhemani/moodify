//
//  AddJournalEntryViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/31/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class AddJournalEntryViewController: UIViewController, UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var journalImageView: UIImageView!
    @IBOutlet weak var journalLabel: UILabel!
    
    @IBAction func addEntry(_ sender: UIButton) {
        let date = selectedDateLabel.text!
        let entry = journalLabel.text!
        let newEntry = JournalEntry(date: date, entry: entry)
        let alert: UIAlertController
        if !JournalEntry.names.contains(date) {
            newEntry.save(as: date)
            alert = UIAlertController(
                title: Storyboard.entrySavedAlert,
                message: "Your entry for \(date) has been successfully saved",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "Ok",
                style: .default
            ))
            present(alert, animated: true)
            resetUI()
        } else {
            let alert = UIAlertController(
                title: Storyboard.dateUsedAlert,
                message: "You have already entered an entry for \(date)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "Replace",
                style: .default,
                handler: { finished in
                    newEntry.save(as: date)
                    self.resetUI()
            }))
            alert.addAction(UIAlertAction(
                title: "Change Date",
                style: .default,
                handler: { finished in
                    self.performSegue(withIdentifier: Storyboard.showDatePickerSegueIdentifier, sender: nil)
            }))
            present(alert, animated: true)
        }
    }

    private func resetUI() {
        let currentDate = Date()
        updateDateLabel(usingDate: currentDate)
        journalImageView.image = nil
        journalLabel.text = "Journal Entry"
    }
    
    @IBAction func importFromCameraRoll(_ sender: UIButton) {
        let actionSheet = UIAlertController(
            title: "Photo Options",
            message: nil,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(
            title: Storyboard.cameraOption,
            style: .default,
            handler: { finished in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.importPicture(withType: .camera)
                } else {
                    print("Cannot access camera")
                }
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: Storyboard.photoLibraryOption,
            style: .default,
            handler: { finished in
                self.importPicture(withType: .photoLibrary)
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: Storyboard.cancelOption,
            style: .cancel
        ))
        present(actionSheet, animated: true)
    }
    
    private func importPicture(withType sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        
        self.present(imagePickerController, animated: true)
    }
    
    // Citation for ImagePicker: https://www.youtube.com/watch?v=he1Whnb9J1s
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            journalImageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    @IBAction private func closePopover(segue: UIStoryboardSegue) {
        if let dpvc = segue.source as? DatePickerViewController {
            let selectedDate = dpvc.datePicker.date
            updateDateLabel(usingDate: selectedDate)
        }
    }
    
    @IBAction private func cancelEditing(segue: UIStoryboardSegue) {
        // nothing to update because user cancelled editing
    }
    
    @IBAction private func doneEditing(segue: UIStoryboardSegue) {
        if let ejvc = segue.source as? EditJournalViewController {
            let journalEntry = ejvc.journalTextView.text
            journalLabel.text = journalEntry
            ejvc.journalTextView.resignFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()
        updateDateLabel(usingDate: currentDate)
    }
    
    // Citation for using Date Formatter: https://coderwall.com/p/b8pz5q/swift-4-current-year-mont-day
    private func updateDateLabel(usingDate date: Date) {
        let format = DateFormatter()
        format.dateFormat = Storyboard.dateFormat
        let selectedDate = format.string(from: date)
        selectedDateLabel.text = selectedDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDatePickerSegueIdentifier {
            if let destination = segue.destination as? DatePickerViewController {
                if let ppc = destination.popoverPresentationController {
                    ppc.delegate = self
                }
            }
        } else if segue.identifier == Storyboard.editSegueIdentifier {
            if let destination = segue.destination.contents as? EditJournalViewController {
                destination.previousText = journalLabel.text!
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    private struct Storyboard {
        static let editSegueIdentifier = "Edit Segue"
        static let showDatePickerSegueIdentifier = "Show Date Picker"
        static let dateFormat = "MM/dd/yyyy"
        static let photoLibraryOption = "Photo Library"
        static let cameraOption = "Camera"
        static let cancelOption = "Cancel"
        static let entrySavedAlert = "Entry Saved"
        static let dateUsedAlert = "Date Already Exists"
    }
    
}
