//
//  CourseStructure.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-22.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation

struct CourseStructure : Codable {
    
    //Mark components
    var average: Double
    
    var kAverage: Double
    var kCourseWeight: Double
    
    var tAverage: Double
    var tCourseWeight: Double
    
    var cAverage: Double
    var cCourseWeight: Double
    
    var aAverage: Double
    var aCourseWeight: Double
    
    var oAverage: Double
    var oCourseWeight: Double
    
    init() {
        
        self.average = -1
        
        self.kAverage = -1
        self.kCourseWeight = -1
        self.tAverage = -1
        self.tCourseWeight = -1
        self.cAverage = -1
        self.cCourseWeight = -1
        self.aAverage = -1
        self.aCourseWeight = -1
        self.oAverage = -1
        self.oCourseWeight = -1
        
    }
    
    init(average: Double, kAverage: Double, kCourseWeight: Double, tAverage: Double, tCourseWeight: Double, cAverage: Double, cCourseWeight: Double, aAverage: Double, aCourseWeight: Double, oAverage: Double, oCourseWeight: Double) {
        
        self.average = average
        
        self.kAverage = kAverage
        self.kCourseWeight = kCourseWeight
        self.tAverage = tAverage
        self.tCourseWeight = tCourseWeight
        self.cAverage = cAverage
        self.cCourseWeight = cCourseWeight
        self.aAverage = aAverage
        self.aCourseWeight = aCourseWeight
        self.oAverage = oAverage
        self.oCourseWeight = oCourseWeight
        
    }
    
}
