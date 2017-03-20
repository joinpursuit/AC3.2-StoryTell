//
//  StitchExtension.swift
//  StoryTell
//
//  Created by Simone on 3/20/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import Foundation

extension StitchViewController {
    
    func getStory() {
        let content = proseTextView.text!
        let linkpath = buildStory.getLinkPath(input: content)
        
        print("\n\n\n\n\(linkpath)\n\n\n\n")
        
        //branchLine is tableView cell
        
    }
}
