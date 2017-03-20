//
//  Stitch.swift
//  StoryTell
//
//  Created by Simone on 3/9/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import Foundation

struct Option {
    let prompt: String
    let link: String
}

class Stitch {
    var content: String
    let options: [Option]
    
    let key: String
    
    init(content: String, options: [Option], key: String) {
        self.content = content
        self.options = options
        self.key = key
    }
    
    convenience init?(with dict: [String:Any], key: String) {
        var tempOptions = [Option]()
        var content: String = ""
        
        
        
        guard let contentArr = dict["content"] as? [Any] else { return nil }
        guard let content2 = contentArr[0] as? String else { return nil }
        content = content2
        
        for item in contentArr {
            if let contentDict = item as? [String:Any] {
                var newOption = String()
                var newPath = String()
                for (dictKey, dictValue) in contentDict {
                    if dictKey == "divert" {
                        
                        newPath = dictValue as! String

                        newOption = "Next"

                    }
                        
                    else if dictKey == "option" {
                        newOption = dictValue as! String
                    }
                        
                    else if dictKey == "linkPath" {
                        newPath = dictValue as! String
                    }
                    
                }
                if newPath != "" {
                    let option = Option(prompt: newOption, link: newPath)
                    tempOptions.append(option)
                }
            }
        }
        
        
        self.init(content: content, options: tempOptions, key: key)
        
    }
    
    static func getStitches(from dict: [String:Any]) -> [String:Stitch] {
        var stitches:[String:Stitch] = [:]
        for (key, value) in dict {
            
           // dump(key)
            if let newDict = value as? [String:Any] {
                let stitch = Stitch(with: newDict, key: key)
                
                stitches[key] = stitch
            }
        }
        return stitches
    }
    
}
