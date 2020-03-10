//
//  PreviewViewController.swift
//  Snapagram
//
//  Created by Nikhil Yerasi on 3/10/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

// do we need this?
protocol ThreadsCollectionViewDelegate {
    func refreshThread(thread: Thread)
}

class PreviewViewController: UIViewController {
    
    @IBOutlet var threadImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    
    var chosenThread: Thread?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        threadImageView.contentMode = .scaleAspectFit
    }
    
    func updateImage() {
        // fill imageView and update Thread instance
        let currentFeedEntry = chosenThread?.entries?.removeFirst()
        if let entry = currentFeedEntry {
            threadImageView.image = entry.image
            usernameLabel.text = entry.name
        }
    }
    @IBAction func buttonTapped(_ sender: Any) {
        if let count = chosenThread?.entries?.count {
            if count > 0 {
                updateImage()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
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
