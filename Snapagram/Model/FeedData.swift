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

class Thread: Equatable {
    var name: String
    var emoji: String
    var unread: Int
    var entries: [ThreadEntry]?
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
        self.unread = 0
        self.entries = [ThreadEntry]()
    }
    
    // for checking equality between thread instances to update entries
    static func == (lhs: Thread, rhs: Thread) -> Bool {
        return lhs.name == rhs.name
    }
}

struct ThreadEntry {
    var name: String
    var image: UIImage?
}

struct Post {
    var location: String
    var image: UIImage?
    var user: String
    var caption: String
    var date: Date
}

class FeedData {
    // initialized without unread counts for students to populate with their own content
    var threads: [Thread] = [
        Thread(name: "memes", emoji: "😂"),
        Thread(name: "dogs", emoji: "🐶"),
        Thread(name: "fashion", emoji: "🕶"),
        Thread(name: "fam", emoji: "👨‍👩‍👧‍👦"),
        Thread(name: "tech", emoji: "💻"),
        Thread(name: "eats", emoji: "🍱"),
    ]
    var posts: [Post] = [
        Post(location: "New York City", image: UIImage(named: "skyline"), user: "nyerasi", caption: "Concrete jungle, wet dreams tomato 🍅 —Alicia Keys", date: Date()),
        Post(location: "Memorial Stadium", image: UIImage(named: "garbers"), user: "rjpimentel", caption: "Last Cal Football game of senior year!", date: Date()),
        Post(location: "Soda Hall", image: UIImage(named: "soda"), user: "chromadrive", caption: "Find your happy place 💻", date: Date())
    ]
    
    func addPost(post: Post) {
        posts.append(post)
    }
    
    func addThreadEntry(threadName: String, threadEntry: ThreadEntry) {
        for availableThread in threads {
            if availableThread.name == threadName {
                availableThread.entries?.append(threadEntry)
                availableThread.unread += 1
            }
        }
    }
    
    func addThread(thread: Thread) {
        threads.append(thread)
    }
}

// write firebase functions here (pushing, pulling, etc.) 
