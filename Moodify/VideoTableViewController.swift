//
//  VideoTableViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/30/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController {
    
    
    var mood: Mood = .happy
    lazy var videos = Dictionaries.moodToVideos[mood] ?? Dictionaries.moodToVideos[.happy]!
    var selectedVideo: VideoInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.videoCellIdentifier, for: indexPath)
        if let videoCell = cell as? VideoTableViewCell {
            videoCell.videoNameLabel.text = videos[indexPath.row].name
            videoCell.thumbnail = nil
            let url = URL(string: Storyboard.imageLinkBefore + videos[indexPath.row].identifier + Storyboard.imageLinkAfter)!
            videoCell.spinner?.startAnimating()
            DispatchQueue.global(qos: .default).async {
                if let imageData = try? Data(contentsOf: url), let newImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        videoCell.thumbnail = newImage
                    }
                }
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Storyboard.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideo = videos[indexPath.row]
        performSegue(withIdentifier: Storyboard.showVideoSegueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showVideoSegueIdentifier {
            if let wvc = segue.destination as? WebsiteViewController {
                wvc.urlString = Storyboard.normalLink + selectedVideo!.identifier
            }
        }
    }
    
    private struct Storyboard {
        static let imageLinkBefore = "https://img.youtube.com/vi/"
        static let imageLinkAfter = "/0.jpg"
        static let normalLink = "https://www.youtube.com/watch?v="
        static let cellHeight = CGFloat(120)
        static let showVideoSegueIdentifier = "Show Video"
        static let videoCellIdentifier = "Video Cell"
    }

}
