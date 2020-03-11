//
//  PostImageViewController.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostImageViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
        
    var image: UIImage!
    @IBOutlet var imageDisplay: UIImageView!
    @IBOutlet var threadsCollectionView: UICollectionView!
    
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var createThreadButton: UIButton!
        
    override func viewWillAppear(_ animated: Bool) {
        threadsCollectionView.reloadData()
    }

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
    
    func displayAlert() {
        // success/error handling
    }
    
    func publishFeedPost() {
        if let location = locationTextField.text, let caption = captionTextField.text, let image = self.image {
            let newPost = Post(location: location, image: image, user: "you", caption: caption, date: Date())
            feed.addPost(post: newPost)
        }
    }
    
    func postThreadEntry(threadName: String) {
        // need to access username
        if let image = self.image {
            let newEntry = ThreadEntry(name: "you", image: image)
            feed.addThreadEntry(threadName: threadName, threadEntry: newEntry)
        }
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        publishFeedPost()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.threads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseThreadCell", for: indexPath) as? ChooseThreadCollectionViewCell {
            let currentThread = feed.threads[indexPath.item]
            cell.nameLabel.text = currentThread.name
            cell.emojiLabel.text = currentThread.emoji
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // update local model
        // present "success" alert view controller
        // segue to feed view
        let currentThread = feed.threads[indexPath.item]
        postThreadEntry(threadName: currentThread.name)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateThreadViewController {
            // pass newly created feed entry!
            let newEntry = ThreadEntry(name: "you", image: image)
            dest.threadEntry = newEntry
        }
    }
}
