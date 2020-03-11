//
//  PreviewViewController.swift
//  Snapagram
//
//  Created by Nikhil Yerasi on 3/10/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet var threadImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var threadNameLabel: UILabel!
    
    var chosenThread: Thread?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        threadImageView.contentMode = .scaleAspectFit
        updateThreadContent()
    }
    
    // updates the ui if the chosen thread has more entries
    @IBAction func buttonTapped(_ sender: Any) {
        if let thread = chosenThread {
            if thread.count() > 0 {
                updateThreadContent()
            } else {
                // unwind to the feed view controller
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func updateThreadContent() {
        // fill imageView, update labels using Thread "dequeue" function
        if let name = chosenThread?.name, let emoji = chosenThread?.emoji {
            threadNameLabel.text = "\(name) \(emoji)"
        }
        
        if let entry = chosenThread?.removeEntry() {
            threadImageView.image = entry.image
            usernameLabel.text = entry.name
        } else {
            let alertController = configureAlertViewController(title: "Whoops!", message: "There was an error opening the chosen Thread.")
            alertController.present(alertController, animated: true, completion: nil)
        }
    }
    
    // initializes and returns an alert controller with a title and a message
    func configureAlertViewController(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        return alertController
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
