//
//  FeedViewController.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var threadCollectionView: UICollectionView!
    @IBOutlet var postTableView: UITableView!
    
//    var feed = FeedData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        threadCollectionView.delegate = self
        threadCollectionView.dataSource = self

        postTableView.delegate = self
        postTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.threads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "threadCell", for: indexPath) as? ThreadCollectionViewCell {
            let currentThread = feed.threads[indexPath.item]
            
            cell.threadBackground.layer.cornerRadius =  cell.threadBackground.frame.width / 2
            cell.threadBackground.layer.borderWidth = 3
            cell.threadBackground.layer.masksToBounds = true
            
            if currentThread.unread > 0 {
                cell.threadUnreadCountLabel.text = "\(currentThread.unread)"
                cell.threadUnreadCountLabel.layer.cornerRadius = cell.threadUnreadCountLabel.frame.width / 2
                cell.threadUnreadCountLabel.layer.masksToBounds = true
                //                cell.threadBackground.layer.borderColor = snapagramYellow.cgColor
            } else {
                cell.threadUnreadCountLabel.alpha = 0
                //                cell.threadBackground.layer.borderColor = snapagramBlue.cgColor
            }
            
            cell.threadNameLabel.text = currentThread.name
            cell.threadEmojiLabel.text = currentThread.emoji
            
            return cell
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 475
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of posts: \(feed.posts.count)")
        return feed.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell {
            // configure cell
            let currentPost = feed.posts[indexPath.row]
            
            if let image = currentPost.image as? UIImage {
                cell.postImageView.image = image
            }
            cell.locationLabel.text = currentPost.location
            cell.timeLabel.text = formatDate(date: currentPost.date)
            cell.posterLabel.text = currentPost.user
            cell.captionLabel.text = currentPost.caption
            return cell
        }
        return UITableViewCell()
    }
    
    func formatDate(date: Date) -> String {
        // returns a concise string corresponding to time since post
        return "30 seconds ago"
    }
    
}