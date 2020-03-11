//
//  FeedData.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import Foundation
import UIKit

// create one instance of the FeedData class 
var feed = FeedData()

class Thread: Equatable {
    var name: String
    var emoji: String
    var unread: Int = 0
    var entries: [ThreadEntry]?
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
        self.entries = [ThreadEntry]()
    }
    
    // for checking rudimentary equality between thread instances to update entries — think: when would this fail?
    static func == (lhs: Thread, rhs: Thread) -> Bool {
        return lhs.name == rhs.name && lhs.count() == rhs.count()
    }
    
    // "enqueues" another entry into this thread
    func addEntry(threadEntry: ThreadEntry) {
        entries?.append(threadEntry)
        unread += 1
    }
    
    // "dequeues" the first entry from this thread and returns it
    func removeEntry() -> ThreadEntry? {
        if unread > 0 {
            unread -= 1
        }
        return entries?.removeFirst()
    }
    
    // returns the length of the thread
    func count() -> Int {
        return entries?.count ?? 0
    }
}

// abstract structure for each thread entry
struct ThreadEntry {
    var name: String
    var image: UIImage?
}

// abstract structure for each feed post
struct Post {
    var location: String
    var image: UIImage?
    var user: String
    var caption: String
    var date: Date
}


// this houses all of our data in the absence of Firebase or an implementation using CoreData
class FeedData {
    // initialized without unread counts for students to populate with their own content
    
    func populate(threads: [Thread]?, posts: [Post]?) {
        // to initialize with entries, implement with an additional func
    }
    
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
                availableThread.addEntry(threadEntry: threadEntry)
            }
        }
    }
    
    func addThread(thread: Thread) {
        threads.append(thread)
    }
}

// write firebase/core data functions here (pushing, pulling, etc.) 
