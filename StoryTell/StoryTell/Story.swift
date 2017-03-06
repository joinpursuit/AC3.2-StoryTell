//
//  Story.swift
//  StoryTell
//
//  Created by Simone on 3/4/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import Foundation

class Story {
    var title: String
    var authorName: String
    var createdAt: String
    var linkPath: String
    var stitches: [String:Any]
    
    init(title:String, authorName:String, createdAt:String, linkPath:String, stitches: [String:Any]) {
        self.title = title
        self.authorName = authorName
        self.createdAt = createdAt
        self.linkPath = linkPath
        self.stitches = stitches
    }
    
    convenience init?(dict: [String:Any]) {
        guard let title = dict["title"] as? String else { return nil }
        guard let createdAt = dict["created_at"] as? String else { return nil }
        guard let dataDict = dict["data"] as? [String:Any] else { return nil }
        guard let stitches = dataDict["stitches"] as? [String:Any] else { return nil }
        guard let linkPath = dataDict["initial"] as? String else { return nil }
        guard let editorData = dataDict["editorData"] as? [String:Any] else { return nil }
        guard let authorName = editorData["authorName"] as? String else { return nil }
        
        self.init(title:title, authorName:authorName, createdAt:createdAt, linkPath:linkPath, stitches:stitches)
    }
    
    static func readStory() -> [Story]? {
        var story = [Story]()
        
        let jsonDoc = Bundle.main.path(forResource: "SampleStory", ofType: "json")
        let jsonURL = URL(fileURLWithPath: jsonDoc!)
        let data = try? Data(contentsOf: jsonURL)
        
        do {
            guard let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] else { return nil }
            if let storyDict = Story(dict: jsonDict) {
                story.append(storyDict)
            }
        } catch {
            print(error)
        }
        return story
    }    
}
