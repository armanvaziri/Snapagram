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
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var memesThreadButton: UIButton!
    @IBOutlet weak var dogsThreadButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDisplay.image = self.image
        miscUISetup()
        // Do any additional setup after loading the view.
    }
    
    func miscUISetup() {
        locationTextField.delegate = self
        captionTextField.delegate = self
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
    }
    

}
