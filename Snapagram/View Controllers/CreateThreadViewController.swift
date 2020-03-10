//
//  CreateThreadViewController.swift
//  Snapagram
//
//  Created by Nikhil Yerasi on 3/10/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class CreateThreadViewController: UIViewController {

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var emojiLabel: UITextField!
    
    @IBOutlet var publishButton: UIButton!
    
    var feedData: FeedData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        publishButton.layer.cornerRadius = publishButton.frame.height / 2
        publishButton.backgroundColor = .white
        publishButton.setTitleColor(Constants.snapagramBlue, for: .normal)
    }
    @IBAction func publishThreadTapped(_ sender: Any) {
        // need to update post image view controller following creation of a new thread
        if let name = nameLabel.text, let emoji = emojiLabel.text, let data = feedData {
            let thread = Thread(name: name, emoji: emoji)
            data.addThread(thread: thread)
        }
    }
    

    private func makeEffectView() {
            let effect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            effectView = UIVisualEffectView(effect: effect)
            effectView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height)
            self.window?.addSubview(effectView)
        }

    private func removeEffectView() {
            if effectView != nil {
                self.effectView.removeFromSuperview()
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
