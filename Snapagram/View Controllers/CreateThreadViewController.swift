//
//  CreateThreadViewController.swift
//  Snapagram
//
//  Created by Nikhil Yerasi on 3/10/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class CreateThreadViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var emojiLabel: UITextField!
    
    @IBOutlet var publishButton: UIButton!
    
    var threadEntry: ThreadEntry?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        publishButton.layer.cornerRadius = publishButton.frame.height / 2
        publishButton.backgroundColor = Constants.snapagramBlue
        publishButton.setTitleColor(.white, for: .normal)
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
    
    @IBAction func publishThreadTapped(_ sender: Any) {
        // creates a new thread, pushes the current entry, and pops to the camera view controller
        if let name = nameLabel.text, let emoji = emojiLabel.text, let entry = threadEntry {
            let thread = Thread(name: name, emoji: emoji)
            feed.addThread(thread: thread)
            feed.addThreadEntry(threadName: name, threadEntry: entry)
            navigationController?.popToRootViewController(animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
