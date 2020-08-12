//
//  CourseResponse.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-22.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation
import SwiftSoup

struct CourseResponse {
    
    let evaluations: [Evaluation]
    let courseStructure: CourseStructure
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else {
            throw HTMLError.badInnerHTML
        }
        
        var evaluations = [Evaluation]()
        var courseStructure: CourseStructure
        
        var evalName: String = ""
        var k: Double = -1
        var kWeight: Double = -1
        var kScore: String = ""
        var t: Double = -1
        var tWeight: Double = -1
        var tScore: String = ""
        var c: Double = -1
        var cWeight: Double = -1
        var cScore: String = ""
        var a: Double = -1
        var aWeight: Double = -1
        var aScore: String = ""
        var o: Double = -1
        var oWeight: Double = -1
        var oScore: String = ""
        var overall: Double = 0
        
        var average: Double = 0
        var kCourse: Double = 0
        var kCourseWeight: Double = -1
        var tCourse: Double = 0
        var tCourseWeight: Double = -1
        var cCourse: Double = 0
        var cCourseWeight: Double = -1
        var aCourse: Double = 0
        var aCourseWeight: Double = -1
        var oCourse: Double = 0
        var oCourseWeight: Double = -1
        
        var kSum: Double = 0
        var kWeightSum: Double = 0
        var tSum: Double = 0
        var tWeightSum: Double = 0
        var cSum: Double = 0
        var cWeightSum: Double = 0
        var aSum: Double = 0
        var aWeightSum: Double = 0
        var oSum: Double = 0
        var oWeightSum: Double = 0
        
        let doc = try SwiftSoup.parse(htmlString)
        
        if let body = try doc.getElementsByAttributeValue("width", "100%").first() {
            let body2 = try body.getElementsByTag("tbody").first()
            for (i, tr) in body2!.children().enumerated() {
                if i % 2 != 0 {
                    var markSum: Double = 0
                    var weightSum: Double = 0
                    for td in tr.children() {
                        if let body3 = try td.getElementsByAttributeValue("rowspan", "2").first() {
                            evalName = try body3.text()
                        }
                        else if let body3 = try td.getElementsByAttributeValue("bgcolor", "ffffaa").last()?.getElementsByAttribute("bgcolor").last(){
                            var str: String
                            var n1 : Double
                            var n2 : Double
                            let holder = try body3.text()
                            if holder != "" {
                                
                                //print(holder)
                                
                                let indexHolder4 = holder.firstIndex(of: "=")
                                if indexHolder4 == nil {
                                    kScore = "..."
                                }
                                else {
                                    str = String(holder[...indexHolder4!])
                                    kScore = String(str.dropLast(2))
                                }
                                
                                if holder.contains("%") && holder.first != "/" && !holder.contains("no mark") {
                                    let indexHolder = kScore.firstIndex(of: "/")
                                    str = String(kScore[...indexHolder!])
                                    str = String(str.dropLast(2))
                                    n1 = Double(str)!
                                    str = String(kScore[indexHolder!...])
                                    str = String(str.dropFirst(2))
                                    n2 = Double(str)!
                                    k = (n1 / n2) * 100
                                }
                                else if holder.first == "0" {
                                    k = 0
                                }
                                else {
                                    k = -1
                                }

                                if holder.contains("no weight") {
                                    kWeight = 0
                                }
                                else {
                                    let indexHolder3 = holder.lastIndex(of: "=")
                                    if indexHolder3 == nil {
                                        kWeight = -1
                                    }
                                    else {
                                        str = String(holder[indexHolder3!...])
                                        kWeight = Double(String(str.dropFirst()))!
                                    }
                                }
                                
                                if k >= 0 {
                                    markSum += k * kWeight
                                    weightSum += kWeight
                                
                                    kSum += k * kWeight
                                    kWeightSum += kWeight
                                }
                            }
                            else {
                                k = -1
                                kWeight = -1
                                kScore = "..."
                            }
                        }
                        else if let body3 = try td.getElementsByAttributeValue("bgcolor", "c0fea4").last()?.getElementsByAttribute("bgcolor").last(){
                            var str: String
                            var n1 : Double
                            var n2 : Double
                            let holder = try body3.text()
                            if holder != "" {
                                
                                let indexHolder4 = holder.firstIndex(of: "=")
                                if indexHolder4 == nil {
                                    tScore = "..."
                                }
                                else {
                                    str = String(holder[...indexHolder4!])
                                    tScore = String(str.dropLast(2))
                                }
                                
                                if holder.contains("%") && holder.first != "/" && !holder.contains("no mark") {
                                    let indexHolder = tScore.firstIndex(of: "/")
                                    str = String(tScore[...indexHolder!])
                                    str = String(str.dropLast(2))
                                    n1 = Double(str)!
                                    str = String(tScore[indexHolder!...])
                                    str = String(str.dropFirst(2))
                                    n2 = Double(str)!
                                    t = (n1 / n2) * 100
                                }
                                else if holder.first == "0" {
                                    t = 0
                                }
                                else {
                                    t = -1
                                }
                                
                                if holder.contains("no weight") {
                                    tWeight = 0
                                }
                                else {
                                    let indexHolder3 = holder.lastIndex(of: "=")
                                    if indexHolder3 == nil {
                                        tWeight = -1
                                    }
                                    else {
                                        str = String(holder[indexHolder3!...])
                                        tWeight = Double(String(str.dropFirst()))!
                                    }
                                }
                                if t >= 0 {
                                    markSum += t * tWeight
                                    weightSum += tWeight
                                
                                    tSum += t * tWeight
                                    tWeightSum += tWeight
                                }
                            }
                            else {
                                t = -1
                                tWeight = -1
                                tScore = "..."
                            }
                        }
                        else if let body3 = try td.getElementsByAttributeValue("bgcolor", "afafff").last()?.getElementsByAttribute("bgcolor").last(){
                            var str: String
                            var n1 : Double
                            var n2 : Double
                            let holder = try body3.text()
                            if holder != "" {
                                
                                let indexHolder4 = holder.firstIndex(of: "=")
                                if indexHolder4 == nil {
                                    cScore = "..."
                                }
                                else {
                                    str = String(holder[...indexHolder4!])
                                    cScore = String(str.dropLast(2))
                                }
                                if holder.contains("%") && holder.first != "/" && !holder.contains("no mark") {
                                    let indexHolder = cScore.firstIndex(of: "/")
                                    str = String(cScore[...indexHolder!])
                                    str = String(str.dropLast(2))
                                    n1 = Double(str)!
                                    str = String(cScore[indexHolder!...])
                                    str = String(str.dropFirst(2))
                                    n2 = Double(str)!
                                    c = (n1 / n2) * 100
                                }
                                else if holder.first == "0" {
                                    c = 0
                                }
                                else {
                                    c = -1
                                }
                                
                                if holder.contains("no weight") {
                                    cWeight = 0
                                }
                                else {
                                    let indexHolder3 = holder.lastIndex(of: "=")
                                    if indexHolder3 == nil {
                                        cWeight = -1
                                    }
                                    else {
                                        str = String(holder[indexHolder3!...])
                                        cWeight = Double(String(str.dropFirst()))!
                                    }
                                }
                                
                                if c >= 0 {
                                    markSum += c * cWeight
                                    weightSum += cWeight
                                
                                    cSum += c * cWeight
                                    cWeightSum += cWeight
                                }
                            }
                            else {
                                c = -1
                                cWeight = -1
                                cScore = "..."
                            }
                        }
                        else if let body3 = try td.getElementsByAttributeValue("bgcolor", "ffd490").last()?.getElementsByAttribute("bgcolor").last(){
                            var str: String
                            var n1 : Double
                            var n2 : Double
                            let holder = try body3.text()
                            if holder != "" {
                                
                                let indexHolder4 = holder.firstIndex(of: "=")
                                if indexHolder4 == nil {
                                    aScore = "..."
                                }
                                else {
                                    str = String(holder[...indexHolder4!])
                                    aScore = String(str.dropLast(2))
                                }
                                
                                if holder.contains("%") && holder.first != "/" && !holder.contains("no mark") {
                                    let indexHolder = aScore.firstIndex(of: "/")
                                    str = String(aScore[...indexHolder!])
                                    str = String(str.dropLast(2))
                                    n1 = Double(str)!
                                    str = String(aScore[indexHolder!...])
                                    str = String(str.dropFirst(2))
                                    n2 = Double(str)!
                                    a = (n1 / n2) * 100
                                }
                                else if holder.first == "0" {
                                    a = 0
                                }
                                else {
                                    a = -1
                                }
                                
                                if holder.contains("no weight") {
                                    aWeight = 0
                                }
                                else {
                                    let indexHolder3 = holder.lastIndex(of: "=")
                                    if indexHolder3 == nil {
                                        aWeight = -1
                                    }
                                    else {
                                        str = String(holder[indexHolder3!...])
                                        aWeight = Double(String(str.dropFirst()))!
                                    }
                                }
                                
                                if a >= 0 {
                                    markSum += a * aWeight
                                    weightSum += aWeight
                                
                                    aSum += a * aWeight
                                    aWeightSum += aWeight
                                }
                            }
                            else {
                                a = -1
                                aWeight = -1
                                aScore = "..."
                            }
                        }
                        else if let body3 = try td.getElementsByAttributeValue("bgcolor", "#dedede").last()?.getElementsByAttribute("bgcolor").last(){
                            var str: String
                            var n1 : Double
                            var n2 : Double
                            let holder = try body3.text()
                            if holder != "" {
                                
                                let indexHolder4 = holder.firstIndex(of: "=")
                                if indexHolder4 == nil {
                                    oScore = "..."
                                }
                                else {
                                    str = String(holder[...indexHolder4!])
                                    oScore = String(str.dropLast(2))
                                }
                                if holder.contains("%") && holder.first != "/" && !holder.contains("no mark") {
                                    let indexHolder = oScore.firstIndex(of: "/")
                                    str = String(oScore[...indexHolder!])
                                    str = String(str.dropLast(2))
                                    n1 = Double(str)!
                                    str = String(oScore[indexHolder!...])
                                    str = String(str.dropFirst(2))
                                    n2 = Double(str)!
                                    o = (n1 / n2) * 100
                                }
                                else if holder.first == "0" {
                                    o = 0
                                }
                                else {
                                    o = -1
                                }
                                
                                if holder.contains("no weight") {
                                    oWeight = 0
                                }
                                else {
                                    let indexHolder3 = holder.lastIndex(of: "=")
                                    if indexHolder3 == nil {
                                        oWeight = -1
                                    }
                                    else {
                                        str = String(holder[indexHolder3!...])
                                        oWeight = Double(String(str.dropFirst()))!
                                    }
                                }
                                
                                if o >= 0 {
                                    markSum += o * oWeight
                                    weightSum += oWeight
                                
                                    oSum += o * oWeight
                                    oWeightSum += oWeight
                                }
                            }
                            else {
                                o = -1
                                oWeight = -1
                                oScore = "..."
                            }
                        }
                    }
                    if weightSum > 0 {
                        overall = Double(markSum) / Double(weightSum)
                    }
                    else {
                        overall = -1
                    }
                    let evaluation = Evaluation(name: evalName, k: k, kWeight: kWeight, kScore: kScore, t: t, tWeight: tWeight, tScore: tScore, c: c, cWeight: cWeight, cScore: cScore, a: a, aWeight: aWeight, aScore: aScore, o: o, oWeight: oWeight, oScore: oScore, overall: overall)
                    evaluations.append(evaluation)
                }
            }
        }
        
        if let body4 = try doc.getElementsByAttributeValue("bgcolor", "#ffffaa").last() {
                for (i, td) in body4.children().enumerated() {
                    if i == 2 {
                        let holder = try td.text()
                        kCourseWeight = Double(holder.dropLast(1))!
                    }
                }
        }
        if let body4 = try doc.getElementsByAttributeValue("bgcolor", "#c0fea4").last() {
            for (i, td) in body4.children().enumerated() {
                if i == 2 {
                    let holder = try td.text()
                    tCourseWeight = Double(holder.dropLast(1))!
                }
            }
        }
        if let body4 = try doc.getElementsByAttributeValue("bgcolor", "#afafff").last() {
            for (i, td) in body4.children().enumerated() {
                if i == 2 {
                    let holder = try td.text()
                    cCourseWeight = Double(holder.dropLast(1))!
                }
            }
        }
        if let body4 = try doc.getElementsByAttributeValue("bgcolor", "#ffd490").last() {
            for (i, td) in body4.children().enumerated() {
                if i == 2 {
                    let holder = try td.text()
                    aCourseWeight = Double(holder.dropLast(1))!
                }
            }
        }
        if let body4 = try doc.getElementsByAttributeValue("bgcolor", "#eeeeee").last() {
            for (i, td) in body4.children().enumerated() {
                if i == 2 {
                    let holder = try td.text()
                    oCourseWeight = Double(holder.dropLast(1))!
                }
            }
        }
        if let body4 = try doc.getElementsByAttributeValue("bgcolor", "#cccccc").last() {
            for (i, td) in body4.children().enumerated() {
                if i == 1 {
                    let holder = try td.text()
                    oCourseWeight += Double(holder.dropLast(1))!
                }
            }
        }
        
        if kCourseWeight == -1 || tCourseWeight == -1 || cCourseWeight == -1 || aCourseWeight == -1 || oCourseWeight == -1 {
            kCourseWeight = 20
            tCourseWeight = 20
            cCourseWeight = 20
            aCourseWeight = 20
            oCourseWeight = 20
            if let body4 = try doc.getElementsByTag("img").last()?.getElementsByAttribute("src").last()?.attr("src") {
                
                if body4.contains("arcs") {
                    
                    var holder = String(body4[body4.firstIndex(of: "k")!...body4.firstIndex(of: "v")!])
                    //print(holder)
                    kCourseWeight = Double(String(holder[holder.firstIndex(of: "=")!...holder.firstIndex(of: "&")!]).dropFirst().dropLast())! * 100
                    //print(kCourseWeight)
                    holder = String(holder[holder.firstIndex(of: "t")!...])
                    //print(holder)
                    tCourseWeight = Double(String(holder[holder.firstIndex(of: "=")!...holder.firstIndex(of: "&")!]).dropFirst().dropLast())! * 100
                    //print(tCourseWeight)
                    holder = String(holder[holder.firstIndex(of: "c")!...])
                    //print(holder)
                    cCourseWeight = Double(String(holder[holder.firstIndex(of: "=")!...holder.firstIndex(of: "&")!]).dropFirst().dropLast())! * 100
                    //print(cCourseWeight)
                    holder = String(holder[holder.firstIndex(of: "a")!...])
                    //print(holder)
                    aCourseWeight = Double(String(holder[holder.firstIndex(of: "=")!...holder.firstIndex(of: "&")!]).dropFirst().dropLast())! * 100
                    //print(aCourseWeight)
                    holder = String(holder[holder.firstIndex(of: "n")!...])
                    //print(holder)
                    oCourseWeight = Double(String(holder[holder.firstIndex(of: "=")!...holder.firstIndex(of: "&")!]).dropFirst().dropLast())! * 100
                    //print(oCourseWeight)
                    holder = String(holder[holder.firstIndex(of: "f")!...])
                    //print(holder)
                    oCourseWeight += Double(String(holder[holder.firstIndex(of: "=")!...holder.firstIndex(of: "&")!]).dropFirst().dropLast())! * 100
                    oCourseWeight = Double(round(10*oCourseWeight)/10)
                //print(oCourseWeight)
                    
                }
            }

        }
        
        var kCourseHolder : Double
        var kCourseWeightHolder : Double
        if kWeightSum <= 0 {
            kCourse = -1
            kCourseHolder = 0
            kCourseWeightHolder = 0
        }
        else {
            kCourse = kSum / kWeightSum
            kCourseHolder = kCourse
            kCourseWeightHolder = kCourseWeight
        }
        
        var tCourseHolder : Double
        var tCourseWeightHolder : Double
        if tWeightSum <= 0 {
            tCourse = -1
            tCourseHolder = 0
            tCourseWeightHolder = 0
        }
        else {
            tCourse = tSum / tWeightSum
            tCourseHolder = tCourse
            tCourseWeightHolder = tCourseWeight
        }
        
        var cCourseHolder : Double
        var cCourseWeightHolder : Double
        if cWeightSum <= 0 {
            cCourse = -1
            cCourseHolder = 0
            cCourseWeightHolder = 0
        }
        else {
            cCourse = cSum / cWeightSum
            cCourseHolder = cCourse
            cCourseWeightHolder = cCourseWeight
        }
        
        var aCourseHolder : Double
        var aCourseWeightHolder : Double
        if aWeightSum <= 0 {
            aCourse = -1
            aCourseHolder = 0
            aCourseWeightHolder = 0
        }
        else {
            aCourse = aSum / aWeightSum
            aCourseHolder = aCourse
            aCourseWeightHolder = aCourseWeight
        }
        
        var oCourseHolder : Double
        var oCourseWeightHolder : Double
        if oWeightSum <= 0 {
            oCourse = -1
            oCourseHolder = 0
            oCourseWeightHolder = 0
        }
        else {
            oCourse = oSum / oWeightSum
            oCourseHolder = oCourse
            oCourseWeightHolder = oCourseWeight
        }
        
        average = (kCourseHolder * kCourseWeight + tCourseHolder * tCourseWeight + cCourseHolder * cCourseWeight + aCourseHolder * aCourseWeight + oCourseHolder * oCourseWeight) / (kCourseWeightHolder + tCourseWeightHolder + cCourseWeightHolder + aCourseWeightHolder + oCourseWeightHolder)
        if average.isNaN {
            average = -1
            print(average)
        }
        let courseStructures = CourseStructure(average: average, kAverage: kCourse, kCourseWeight: kCourseWeight, tAverage: tCourse, tCourseWeight: tCourseWeight, cAverage: cCourse, cCourseWeight: cCourseWeight, aAverage: aCourse, aCourseWeight: aCourseWeight, oAverage: oCourse, oCourseWeight: oCourseWeight)
        courseStructure = courseStructures
        self.evaluations = evaluations
        self.courseStructure = courseStructure
    }
}

