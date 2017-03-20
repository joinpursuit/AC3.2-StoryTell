//
//  Serialization.swift
//  StoryTell
//
//  Created by Simone on 3/20/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import Foundation

protocol Compatible {
    var JSONCompatible: AnyObject { get }
}

protocol Serialized: Compatible {}

extension Serialized {
    var JSONCompatible: AnyObject {
        var dict = [String:AnyObject]()
        
        for case let (object?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as Compatible:
                dict[object] = value.JSONCompatible
            case let value as NSObject:
                dict[object] = value
            default:
                break
            }
        }
        return dict as AnyObject
    }
    
    func changeToJSON() -> String? {
        let compatible = JSONCompatible
        
        guard JSONSerialization.isValidJSONObject(compatible) else { return nil }
        
        do {
            let json = try JSONSerialization.data(withJSONObject: compatible, options: [])
            return String(data: json, encoding: String.Encoding.utf8)!
        } catch {
            return nil
        }
    }
}

extension Date: Compatible {
    var JSONCompatible: AnyObject {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        return formatter.string(from: self) as AnyObject
    }
}
