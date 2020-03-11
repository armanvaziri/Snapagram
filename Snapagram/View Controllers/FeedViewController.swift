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
    
    var chosenThread: Thread?
    
    override func viewWillAppear(_ animated: Bool) {
        threadCollectionView.reloadData()
        postTableView.reloadData()
        
        for thread in feed.threads {
            if thread.unread > 0 {
                print("thread \(thread.name) has \(thread.unread) entries")
            }
        }
        // coredata/firebase: pull from db to get posts/threads
    }
            
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
            
            // initialize count to 0 if entries is nil
            let count = currentThread.unread
            
            if count > 0 {
                cell.threadUnreadCountLabel.text = "\(count)"
                cell.threadUnreadCountLabel.layer.cornerRadius = cell.threadUnreadCountLabel.frame.width / 2
                cell.threadUnreadCountLabel.layer.masksToBounds = true
            } else {
                cell.threadUnreadCountLabel.alpha = 0
            }
            
            cell.threadNameLabel.text = currentThread.name
            cell.threadEmojiLabel.text = currentThread.emoji
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // segue to preview controller with selected thread
        chosenThread = feed.threads[indexPath.item]
        if let count = chosenThread?.entries?.count {
            if count > 0 {
                performSegue(withIdentifier: "feedToPreview", sender: self)
            } else {
                presentAlertViewController(title: "Hmmm...", message: "This thread has no entries — add some yourself!")
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 475
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell {
            // configure cell
            let currentPost = feed.posts[indexPath.row]
            
            if let image = currentPost.image {
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
    
    func presentAlertViewController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func formatDate(date: Date) -> String {
        // returns a concise string corresponding to time since post
        let timeSince = date.timeIntervalSinceNow.description
        return timeSince
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PreviewViewController {
            dest.chosenThread = chosenThread
        }
    }
    
}
