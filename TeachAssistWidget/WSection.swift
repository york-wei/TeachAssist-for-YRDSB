//
//  Section.swift
//  TeachAssist
//
//  Created by York Wei on 2020-06-13.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation

class Section : Codable, ObservableObject {
    
    var percent : Double = -1.0
    var weight : Double = -1.0
    var score : String = ""
    
    init() {
        
    }
    
    init(percent : Double, weight : Double, score : String) {
        self.percent = percent
        self.weight = weight
        self.score = score
    }
    
    init(section : Section) {
        self.percent = section.percent
        self.weight = section.weight
        self.score = section.score
    }
    
    
}
