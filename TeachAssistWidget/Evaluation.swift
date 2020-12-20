//
//  Evaluation.swift
//  TeachAssist
//
//  Created by York Wei on 2020-06-13.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation

class Evaluation : Codable, Equatable, Identifiable, ObservableObject {
    
    var id = UUID()
    
    var name : String = ""
    var overall : Double = -1.0
    var deleted = false
    
    var knowledge : Section = Section()
    var thinking : Section = Section()
    var communication : Section = Section()
    var application : Section = Section()
    var other : Section = Section()
    var finals : Section = Section()
    
    var feedback : String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case overall
        case knowledge
        case thinking
        case communication
        case application
        case other
        case finals
        case feedback
    }
    
    init(name : String, knowledge: Section, thinking : Section, communication : Section, application : Section, other : Section, finals : Section, overall : Double) {
        self.name = name
        self.knowledge = knowledge
        self.thinking = thinking
        self.communication = communication
        self.application = application
        self.other = other
        self.finals = finals
        self.overall = overall
    }
    
    static func == (lhs: Evaluation, rhs: Evaluation) -> Bool {
        return lhs.name == rhs.name && lhs.overall == rhs.overall
    }
    
}
