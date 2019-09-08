//
//  MusicViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/29/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

import AVFoundation

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mood: Mood = .happy
    var songCurrentlyPlaying : String?
    private lazy var songs = Dictionaries.moodToSongs[mood] ?? Dictionaries.moodToSongs[.happy]!
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer = AVAudioPlayer()
    
    @IBAction func fastForward(_ sender: UIBarButtonItem) {
        if songCurrentlyPlaying == nil { return }
        let indexOfOldSong = songs.firstIndex(of: songCurrentlyPlaying ?? songs[0])!
        let indexOfNewSong = (indexOfOldSong == songs.count - 1) ? 0 : indexOfOldSong + 1
        
        playSong(songs[indexOfNewSong])
        selectSong(newIndex: indexOfNewSong, oldIndex: indexOfOldSong)
    }
    
    @IBAction func rewind(_ sender: UIBarButtonItem) {
        if songCurrentlyPlaying == nil { return }
        let indexOfOldSong = songs.firstIndex(of: songCurrentlyPlaying ?? songs[0])!
        let indexOfNewSong = (indexOfOldSong == 0) ? (songs.count - 1) : (indexOfOldSong - 1)
        
        playSong(songs[indexOfNewSong])
        selectSong(newIndex: indexOfNewSong, oldIndex: indexOfOldSong)
    }
    
    @IBAction func playPause(_ sender: UIBarButtonItem) {
        if songCurrentlyPlaying == nil {
            playSong(songs[0])
            selectSong(newIndex: 0, oldIndex: -1)
            return
        }
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playPauseButton.tintColor = .blue
        } else {
            audioPlayer.play()
            playPauseButton.tintColor = .red
        }
    }
    
    @IBOutlet weak var playPauseButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        playPauseButton?.tintColor = .blue
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.songCellIdentifier, for: indexPath)
        if let songCell = cell as? SongTableViewCell {
            let songName = songs[indexPath.row]
            songCell.songLabel.text = songName
            songCell.artistLabel.text = Dictionaries.songToArtist[songName] ?? Storyboard.unknownArtist
            songCell.songImage = UIImage(named: songName) ?? UIImage(named: Storyboard.noImageIdentifier)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        playSong(song)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Storyboard.heightOfCell
    }
    
    private func playSong(_ song: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: song, ofType: Storyboard.musicFileType) ?? Bundle.main.path(forResource: Storyboard.defaultMusic, ofType: Storyboard.musicFileType)!))
            audioPlayer.play()
            songCurrentlyPlaying = song
            playPauseButton.tintColor = .red
        }
        catch {
            print(error)
        }
    }

    private func selectSong(newIndex: Int, oldIndex: Int) {
        // -1 means don't deselect and/or select
        if oldIndex != -1 {
            let oldIndexPath = IndexPath(row: oldIndex, section: 0)
            tableView.deselectRow(at: oldIndexPath, animated: true)
        }
        
        if newIndex != -1 {
            let newIndexPath = IndexPath(row: newIndex, section: 0)
            tableView.selectRow(at: newIndexPath, animated: true, scrollPosition: .none)
        }
    }
    
    private struct Storyboard {
        static let songCellIdentifier = "Song Cell"
        static let unknownArtist = "Unknown"
        static let noImageIdentifier = "noimage"
        static let musicFileType = "m4a"
        static let defaultMusic = "Fireflies"
        static let heightOfCell = CGFloat(70)
    }
    
}
