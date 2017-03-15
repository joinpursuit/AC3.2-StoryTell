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
    let content: String
    let options: [Option]
    
    init(content: String, options: [Option]) {
        self.content = content
        self.options = options
    }
    
    convenience init?(with dict: [String:Any]) {
        var tempOptions = [Option]()
        var content: String = ""
        for (_, value) in dict {
            //guard let stitchDict = value as? [String: Any] else { return nil }
            guard let contentArr = dict["content"] as? [Any] else { return nil }
            guard let content2 = contentArr[0] as? String else { return nil }
            content = content2
            // nextLine = excerpt
            for item in contentArr {
                if let contentDict = item as? [String:Any] {
                    var newOption = String()
                    var newPath = String()
                    for (dictKey, dictValue) in contentDict {
                        if dictKey == "divert" {
                            //let option = Option(prompt: "", link: dictValue as! String)
                            //tempOptions.append(option)
                            //branches.updateValue(dictValue, forKey: "next")
                            newPath = dictValue as! String
                            newOption = "divert"
                        }
                            
                        else if dictKey == "option" {
                            newOption = dictValue as! String
                        }
                            
                        else if dictKey == "linkPath" {
                            newPath = dictValue as! String
                        }
                            
                            //                        if newOption == "" && newPath == "" {
                            //                            break
                            //                        }
                        else {
                            //branches.updateValue(newPath, forKey: newOption)
                            
                        }
                        
                    }
                    if newPath != "" {
                        let option = Option(prompt: newOption, link: newPath)
                        tempOptions.append(option)
                    }
                }
            }
        }
        self.init(content: content, options: tempOptions)
    }
    
    static func getStitches(from dict: [String:Any]) -> [String:Stitch] {
        var stitches:[String:Stitch] = [:]
        for (key, value) in dict {
            if let newDict = value as? [String:Any] {
                let stitch = Stitch(with: newDict)
                stitches[key] = stitch
            }
        }
        return stitches
    }
    
}
