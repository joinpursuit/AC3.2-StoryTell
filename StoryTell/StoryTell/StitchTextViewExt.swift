//
//  StitchTextViewExt.swift
//  StoryTell
//
//  Created by Simone on 3/17/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

extension StitchViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        //textView.text = story.stitches[keyFromReader]?.content
        if textView.textColor == UIColor.lightGray {
            
            
            textView.text = nil
            textView.textColor = Colors.navy
            print("I am writing NOW")
        }
        textView.becomeFirstResponder()
        promptLabel.text = "Branch: I work" ///////Placeholder
    }
    

    
    
  
    

}
