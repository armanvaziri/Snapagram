//
//  PostImageViewController.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostImageViewController: UIViewController, UITextFieldDelegate {
    
    //    var feed = FeedData()
    
    var image: UIImage!
    @IBOutlet var imageDisplay: UIImageView!
    @IBOutlet var threadsCollectionView: UICollectionView!
    
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var createThreadButton: UIButton!
    
    var feedData: FeedData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDisplay.image = self.image
        
        locationTextField.delegate = self
        captionTextField.delegate = self
        threadsCollectionView.delegate = self
        threadsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        createThreadButton.layer.cornerRadius = createThreadButton.frame.height / 2
        createThreadButton.layer.masksToBounds = true
        postButton.layer.cornerRadius = createThreadButton.frame.height / 2
        postButton.layer.masksToBounds = true
    }
    
    // hide key board when the user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func createThreadButtonPressed(_ sender: Any) {
        // NBY: still need to prepare for this segue
        performSegue(withIdentifier: "postToCreateThread", sender: self)
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        if let location = locationTextField.text as? String, let caption = captionTextField.text as? String, let image = self.image as? UIImage {
            let toPost = Post(location: location, image: image, user: "", caption: caption, date: Date())
            feed.posts.append(toPost)
            //            performSegue(withIdentifier: "postToFeed", sender: sender)
            if let vc = navigationController?.viewControllers.filter({$0 is FeedViewController}).first as? FeedViewController {
                navigationController?.popToViewController(vc, animated: true)
            } else {
                print("cant find it")
            }
            
        } else {
            print("something went wrong with this post")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FeedViewController {
            //            dest.modalPresentationStyle = .fullScreen
            //            dest.feed = self.feed
        }
        if let dest = segue.destination as? CreateThreadViewController {
            // configure delegate behavior here!
        }
    }
}

extension PostImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedData?.threads.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = feedData, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseThreadCell", for: indexPath) as? ThreadCollectionViewCell {
            let currentThread = data.threads[indexPath.item]
            
            cell.threadBackground.layer.cornerRadius =  cell.threadBackground.frame.width / 2
            cell.threadBackground.layer.masksToBounds = true
            cell.threadBackground.backgroundColor = Constants.snapagramBlue
            cell.threadUnreadCountLabel.alpha = 0
            cell.threadNameLabel.text = currentThread.name
            cell.threadEmojiLabel.text = currentThread.emoji
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // update local model
        // present "success" alert view controller
        // segue to feed view
    }
    
}
