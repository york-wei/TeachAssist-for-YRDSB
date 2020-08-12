//
//  Course.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-17.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation

class Course : Codable, Equatable, Identifiable, ObservableObject {
    
    var id = UUID()
    var index : Int
    //Course information
    var code: String
    var name: String
    var period: String
    var room: String
    var link: String
    var parsedMark: Double
    
    //Structure
    var courseStructure: CourseStructure
    
    //Evaluations
    var evaluations: [Evaluation]
    
    //UI
    var updated : Bool
    var averageProgression : [Double]
        
    //Initialize with empty marks
    init(code: String, name: String, period: String, room: String, link: String, parsedMark: Double) {
        
        self.index = -1
        
        self.code = code
        self.name = name
        self.period = period
        self.room = room
        self.link = link
        self.parsedMark = parsedMark
        
        self.courseStructure = CourseStructure()
        
        self.evaluations = [Evaluation]()
        
        self.updated = false
        self.averageProgression = [Double]()
        
    }
    
    init(course: Course) {
        self.index = course.index
        self.code = course.code
        self.name = course.name
        self.period = course.period
        self.room = course.room
        self.link = course.link
        self.parsedMark = course.parsedMark
        self.courseStructure = course.courseStructure
        self.evaluations = course.evaluations
        self.updated = course.updated
        self.averageProgression = course.averageProgression
    }
    
    init () {
        
        self.index = -1
        
        self.code = ""
        self.name = ""
        self.period = ""
        self.room = ""
        self.link = ""
        self.parsedMark = -1
        
        self.courseStructure = CourseStructure()
        
        self.evaluations = [Evaluation]()
        
        self.updated = false
        self.averageProgression = [Double]()
        
    }
    
    init (demo: String) {
        self.index = -1
        self.code = "DEMO-4U1"
        self.name = "Demo Course"
        self.period = "1"
        self.room = "101"
        self.link = ""
        self.parsedMark = 85
        self.courseStructure = CourseStructure(average: 85, kAverage: 85, kCourseWeight: 20, tAverage: 85, tCourseWeight: 20, cAverage: 85, cCourseWeight: 20, aAverage: 85, aCourseWeight: 20, oAverage: 85, oCourseWeight: 20)
        self.evaluations = [Evaluation(name: "Demo Assignment 1", k: 85, kWeight: 5, kScore: "8.5 / 10", t: 85, tWeight: 5, tScore: "8.5 / 10", c: 85, cWeight: 5, cScore: "8.5 / 10", a: 85, aWeight: 5, aScore: "8.5 / 10", o: -1, oWeight: -1, oScore: "", overall: 85), Evaluation(name: "Demo Assignment 2", k: 85, kWeight: 5, kScore: "8.5 / 10", t: 85, tWeight: 5, tScore: "8.5 / 10", c: 85, cWeight: 5, cScore: "8.5 / 10", a: 85, aWeight: 5, aScore: "8.5 / 10", o: -1, oWeight: -1, oScore: "", overall: 85), Evaluation(name: "Demo Assignment 3", k: 85, kWeight: 5, kScore: "8.5 / 10", t: 85, tWeight: 5, tScore: "8.5 / 10", c: 85, cWeight: 5, cScore: "8.5 / 10", a: 85, aWeight: 5, aScore: "8.5 / 10", o: -1, oWeight: -1, oScore: "", overall: 85)]
        self.updated = false
        self.averageProgression = [Double]()
    }
    
    //Check if two courses are the same
    static func == (lhs: Course, rhs: Course) -> Bool {
        
        return lhs.code == rhs.code
        
    }
    
    public static func sortByOpen (this: Course, that: Course) -> Bool {
        return this.courseStructure.average > that.courseStructure.average
    }
    
}
