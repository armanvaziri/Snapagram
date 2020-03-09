//
//  FeedData.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import Foundation
import UIKit

var feed = FeedData()

struct Thread {
    var name: String
    var emoji: String
    var unread: Int
}

struct Post {
    // how to optimize to avoid UIImage?
    var location: String
    var image: UIImage?
    var user: String
    var caption: String
    var date: Date
}

class FeedData {
    var threads: [Thread] = [
        Thread(name: "memes", emoji: "😂", unread: 2),
        Thread(name: "dogs", emoji: "🐶", unread: 1),
        Thread(name: "fashion", emoji: "🕶", unread: 0),
        Thread(name: "fam", emoji: "👨‍👩‍👧‍👦", unread: 0),
        Thread(name: "tech", emoji: "💻", unread: 3),
        Thread(name: "eats", emoji: "🍱", unread: 4),
    ]
    var posts: [Post] = [
        Post(location: "New York City", image: UIImage(named: "skyline"), user: "nyerasi", caption: "Concrete jungle, wet dreams tomato 🍅 —Alicia Keys", date: Date()),
        Post(location: "Memorial Stadium", image: UIImage(named: "garbers"), user: "rjpimentel", caption: "Last Cal Football game of senior year!", date: Date()),
        Post(location: "Soda Hall", image: UIImage(named: "soda"), user: "chromadrive", caption: "Find your happy place 💻", date: Date())
    ]
}

// write firebase functions here (pushing, pulling, etc.) 
