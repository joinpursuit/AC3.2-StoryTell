//
//  BuildStory.swift
//  StoryTell
//
//  Created by Simone on 3/20/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import Foundation

class BuildStory {
    
    func getLinkPath(input: String) -> String {
        var finalArray: [Character] = []
        var whiteSpacedFound: Bool = false
        
        var noPunctuation = input.components(separatedBy: CharacterSet.punctuationCharacters).joined()
        
        let arrayOflettersNoPunctuation = Array(noPunctuation.characters)
        
        for (index, character) in arrayOflettersNoPunctuation.enumerated() {
            
            if index == 0 {
                let convertToString = String(character).lowercased()
                finalArray.append(Character(convertToString))
                continue
            }
            
            if character == " " {
                whiteSpacedFound = true
            } else if character != " " && whiteSpacedFound == true {
                let upperCased = String(character).uppercased()
                finalArray.append(Character(upperCased))
                whiteSpacedFound = false
            } else {
                if character != " " {
                    finalArray.append(character)
                }
            }
            if finalArray.count > 15 {
                return String(finalArray)
            }
        }
        return String(finalArray)
    }
    
    
    
}
