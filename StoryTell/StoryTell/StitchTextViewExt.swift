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
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = Colors.navy
            print("I am writing NOW")
        }
        textView.becomeFirstResponder()
        promptLabel.text = "Branch: I work" ///////Placeholder
    }
    
    func updateTextView(notification:Notification) {
        let userInfo = notification.userInfo!
        let keyboardEndFrameScreenCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            proseTextView.contentInset = UIEdgeInsets.zero
        } else {
            proseTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
            proseTextView.scrollIndicatorInsets = proseTextView.contentInset
        }
        proseTextView.scrollRangeToVisible(proseTextView.selectedRange)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    

}
