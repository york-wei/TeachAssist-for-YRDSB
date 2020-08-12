//
//  Course.swift
//  TeachAssist
//
//  Created by York Wei on 2020-06-13.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation

class Course : Codable, Equatable, Identifiable, ObservableObject {
    
    var id = UUID()
    
    var code : String = ""
    var name : String = ""
    var period : String = ""
    var room : String = ""
    
    var parsedAverage : Double = -1.0
    var calculatedAverage : Double = -1.0
    
    var knowledge : Section = Section()
    var thinking : Section = Section()
    var communication : Section = Section()
    var application : Section = Section()
    var other : Section = Section()
    var finals : Section = Section() 
    
    var evaluations : [Evaluation] = [Evaluation]()
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case period
        case room
        case parsedAverage
        case calculatedAverage
        case knowledge
        case thinking
        case communication
        case application
        case other
        case finals
        case evaluations
    }
    
    init(course: Course) {
        self.code = course.code
        self.name = course.name
        self.period = course.period
        self.room = course.room
        self.parsedAverage = course.parsedAverage
        self.calculatedAverage = course.calculatedAverage
        self.knowledge = Section(section: course.knowledge)
        self.thinking = Section(section: course.thinking)
        self.communication = Section(section: course.communication)
        self.application = Section(section: course.application)
        self.other = Section(section: course.other)
        self.finals = Section(section: course.finals)
        self.evaluations = course.evaluations
    }
    
    init() {
        
    }
    
    init(demo: Bool, i: Int) {
        
        if i == 0 {
        self.code = "MCV4U1-05"
        self.name = "Demo Course"
        self.period = "2"
        self.room = "335"
        self.parsedAverage = 98.5
            self.knowledge = Section(percent: 98.5, weight: 20, score: "")
            self.thinking = Section(percent: 98.5, weight: 20, score: "")
        self.communication = Section(percent: 98.5, weight: 20, score: "")
        self.application = Section(percent: 98.5, weight: 20, score: "")
        self.other = Section(percent: -1, weight: 0, score: "")
        self.finals = Section(percent: 98.5, weight: 20, score: "")
        self.evaluations = [Evaluation(name: "Quiz - Curve Sketching", knowledge: Section(percent: 98.5, weight: 20, score: ""), thinking: Section(percent: 98.5, weight: 20, score: ""), communication: Section(percent: 98.5, weight: 20, score: ""), application: Section(percent: 98.5, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 98.5, weight: 20, score: ""), overall: 98.5), Evaluation(name: "Unit Test - Derivatives", knowledge: Section(percent: 98.5, weight: 20, score: ""), thinking: Section(percent: 98.5, weight: 20, score: ""), communication: Section(percent: 98.5, weight: 20, score: ""), application: Section(percent: 98.5, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 98.5, weight: 20, score: ""), overall: 98.5)]
        }
        else if i == 1 {
            self.code = "ENG4U1-03"
            self.name = "Demo Course"
            self.period = "3"
            self.room = "303"
            self.parsedAverage = 94.2
            self.knowledge = Section(percent: 94.2, weight: 20, score: "")
            self.thinking = Section(percent: 94.2, weight: 20, score: "")
            self.communication = Section(percent: 94.2, weight: 20, score: "")
            self.application = Section(percent: 94.2, weight: 20, score: "")
            self.other = Section(percent: -1, weight: 0, score: "")
            self.finals = Section(percent: 94.2, weight: 20, score: "")
            self.evaluations = [Evaluation(name: "Demo Assignment", knowledge: Section(percent: 94, weight: 20, score: ""), thinking: Section(percent: 94, weight: 20, score: ""), communication: Section(percent: 94, weight: 20, score: ""), application: Section(percent: 94, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 94, weight: 20, score: ""), overall: 94), Evaluation(name: "Demo Assignment", knowledge: Section(percent: 87, weight: 20, score: ""), thinking: Section(percent: 87, weight: 20, score: ""), communication: Section(percent: 87, weight: 20, score: ""), application: Section(percent: 87, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 87, weight: 20, score: ""), overall: 87), Evaluation(name: "Demo Assignment", knowledge: Section(percent: 100, weight: 20, score: ""), thinking: Section(percent: 100, weight: 20, score: ""), communication: Section(percent: 100, weight: 20, score: ""), application: Section(percent: 100, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 100, weight: 20, score: ""), overall: 100)]
        }
        else if i == 2 {
            self.code = "AMS4M1-01"
            self.name = "Demo Course"
            self.period = "5"
            self.room = "134"
            self.parsedAverage = -1.0
            self.knowledge = Section(percent: 85, weight: 20, score: "")
            self.thinking = Section(percent: 85, weight: 20, score: "")
            self.communication = Section(percent: 85, weight: 20, score: "")
            self.application = Section(percent: 85, weight: 20, score: "")
            self.other = Section(percent: -1, weight: 0, score: "")
            self.finals = Section(percent: 85, weight: 20, score: "")
            self.evaluations = [Evaluation(name: "Demo Assignment", knowledge: Section(percent: 85, weight: 20, score: ""), thinking: Section(percent: 85, weight: 20, score: ""), communication: Section(percent: 85, weight: 20, score: ""), application: Section(percent: 85, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 85, weight: 20, score: ""), overall: 85)]
        }
        else if i == 3 {
            self.code = "AMR4M3-01"
            self.name = "Demo Course"
            self.period = "BSP2"
            self.room = "133"
            self.parsedAverage = -1.0
            self.knowledge = Section(percent: 85, weight: 20, score: "")
            self.thinking = Section(percent: 85, weight: 20, score: "")
            self.communication = Section(percent: 85, weight: 20, score: "")
            self.application = Section(percent: 85, weight: 20, score: "")
            self.other = Section(percent: -1, weight: 0, score: "")
            self.finals = Section(percent: 85, weight: 20, score: "")
            self.evaluations = [Evaluation(name: "Demo Assignment", knowledge: Section(percent: 85, weight: 20, score: ""), thinking: Section(percent: 85, weight: 20, score: ""), communication: Section(percent: 85, weight: 20, score: ""), application: Section(percent: 85, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 85, weight: 20, score: ""), overall: 85)]
        }
        else {
            self.code = "DEMO-4U1"
            self.name = "Demo Course"
            self.period = "1"
            self.room = "101"
            self.parsedAverage = 85
            self.knowledge = Section(percent: 85, weight: 20, score: "")
            self.thinking = Section(percent: 85, weight: 20, score: "")
            self.communication = Section(percent: 85, weight: 20, score: "")
            self.application = Section(percent: 85, weight: 20, score: "")
            self.other = Section(percent: -1, weight: 0, score: "")
            self.finals = Section(percent: 85, weight: 20, score: "")
            self.evaluations = [Evaluation(name: "Demo Assignment", knowledge: Section(percent: 85, weight: 20, score: ""), thinking: Section(percent: 85, weight: 20, score: ""), communication: Section(percent: 85, weight: 20, score: ""), application: Section(percent: 85, weight: 20, score: ""), other: Section(percent: -1.0, weight: 0, score: ""), finals: Section(percent: 85, weight: 20, score: ""), overall: 85)]
        }
    }
    
    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.code == rhs.code
    }
    
}
