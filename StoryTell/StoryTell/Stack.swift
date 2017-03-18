//
//  Stack.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/17/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import Foundation



// BEST FUCKING THING I HAVE DONE! DSA MAGIC!! 
struct Stack<Element> {
    var array: [Element] = []
    
    mutating func push(_ element: Element){
        array.append(element)
        
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
        
    }
    
     func peek() -> Element?{
        return array.last
        
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
}


extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider: String = "---Stack---\n"
let bottomDivider: String = "\n-------\n"
        
        let stackElements: String = array.map { "\($0)" }.reversed().joined(separator: "\n")
        
        return topDivider + stackElements + bottomDivider
        
    }
    
}

