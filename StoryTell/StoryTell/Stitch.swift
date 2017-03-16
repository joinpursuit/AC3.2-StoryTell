//
//  Stitch.swift
//  StoryTell
//
//  Created by Simone on 3/9/17.
//  Copyright © 2017 Simone. All rights reserved.
//
<<<<<<< HEAD

=======
>>>>>>> de2d81bf19a6ef31459c079b28fa3fe53a07c395
import Foundation

struct Option {
    let prompt: String
    let link: String
}

class Stitch {
    let content: String
    let options: [Option]
<<<<<<< HEAD
    let key: String
    
    init(content: String, options: [Option], key: String) {
        self.content = content
        self.options = options
        self.key = key
    }
    
    convenience init?(with dict: [String:Any], key: String) {
        var tempOptions = [Option]()
        var content: String = ""
       // for (_, _) in dict {
            
            
            //guard let stitchDict = value as? [String: Any] else { return nil }
            //dump(stitchDict)
=======
    
    init(content: String, options: [Option]) {
        self.content = content
        self.options = options
    }
    
    convenience init?(with dict: [String:Any]) {
        var tempOptions = [Option]()
        var content: String = ""
        for (_, value) in dict {
            //guard let stitchDict = value as? [String: Any] else { return nil }
>>>>>>> de2d81bf19a6ef31459c079b28fa3fe53a07c395
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
<<<<<<< HEAD
        //}
        self.init(content: content, options: tempOptions, key: key)
=======
        }
        self.init(content: content, options: tempOptions)
>>>>>>> de2d81bf19a6ef31459c079b28fa3fe53a07c395
    }
    
    static func getStitches(from dict: [String:Any]) -> [String:Stitch] {
        var stitches:[String:Stitch] = [:]
        for (key, value) in dict {
<<<<<<< HEAD
            dump(key)
            if let newDict = value as? [String:Any] {
                let stitch = Stitch(with: newDict, key: key)
=======
            if let newDict = value as? [String:Any] {
                let stitch = Stitch(with: newDict)
>>>>>>> de2d81bf19a6ef31459c079b28fa3fe53a07c395
                stitches[key] = stitch
            }
        }
        return stitches
    }
    
}
