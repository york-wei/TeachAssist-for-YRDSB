//
//  TeachAssistResponse.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-22.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}

struct TeachAssistResponse {
    
    var courses: [Course]
    
    init(_ innerHTML: Any?) throws {
        
        guard let htmlString = innerHTML as? String else {
            throw HTMLError.badInnerHTML
        }
        
        var courses = [Course]()
        var code: String
        var name: String
        var period: String
        var room: String
        var mark: Double
        var link : String
        
        let doc = try SwiftSoup.parse(htmlString)
        
        for element in (try doc.getElementsByClass("green_border_message box").array()) {
            
            if try element.text().contains("Course Name") { //Find the right element to parse
                
                if let body = try element.getElementsByTag("tbody").first() {
                    
                    for tr in body.children() { //For each course on the reports page
                        
                        if let body2 = try tr.getElementsByAttribute("bgcolor").first(){
                            
                            let infoString = try body2.getElementsByTag("td").first()!.text() //Containing course information
                            let markString = try String(body2.getElementsByTag("td").last()!.text()) //Containing course mark
                            
                            //Retrieve link
                            if try body2.getElementsByTag("a").hasAttr("href"){
                                let holder = try body2.select("a[href]").first()!
                                link = try holder.attr("href")
                            }
                            else {
                                link = "..."
                            }
                            
                            //separate code from parsed infoString
                            if infoString.contains(":") {
                                let nameIndexHolder = infoString.firstIndex(of: ":")
                                let holder = String(infoString[..<nameIndexHolder!])
                                code = String(holder.dropLast(1))
                            }
                            else {
                                code = infoString
                            }
                            
                            //separate code from parsed infoString
                            if infoString.contains(":") && infoString.contains("Block:") {
                                let codeIndexHolder = infoString.firstIndex(of: ":")
                                let codeIndexHolder2 = infoString.lastIndex(of: ":")
                                let holder = String(infoString[codeIndexHolder!...codeIndexHolder2!])
                                let holder2 = holder.dropLast(7)
                                name = String(holder2.dropFirst(2))
                            }
                            else {
                                name = "..."
                            }
                            
                            //separate period from parsed infoString
                            if infoString.contains("Block: ") {
                                let periodIndexHolder = infoString.lastIndex(of: ":")
                                let periodIndexHolder2 = infoString.lastIndex(of: "-")
                                let holder = String(infoString[periodIndexHolder!...periodIndexHolder2!])
                                let periodIndexHolder3 = holder.index(holder.startIndex, offsetBy: 2)
                                let periodIndexHolder4 = holder.index(holder.endIndex, offsetBy: -3)
                                if periodIndexHolder4 < periodIndexHolder3 {
                                    period = "..."
                                }
                                else {
                                    period = String(holder[periodIndexHolder3...periodIndexHolder4])
                                }
                            }
                            else {
                                period = "..."
                            }
                            
                            //separate room from parsed infoString
                            
                            if infoString.contains("rm.") {
                                let roomIndexHolder = infoString.lastIndex(of: ".")
                                let roomIndexHolder2 = infoString.index(infoString.endIndex, offsetBy: -1)
                                let holder = infoString[roomIndexHolder!...roomIndexHolder2]
                                room = String(holder.dropFirst(2))
                            }
                            else {	
                                room = "..."
                            }
                            
                            //separate mark from parsed markString
                            //print(markString)
                            
                            if markString.contains("current mark") {
                                let markStringIndex = markString.firstIndex(of: "=")
                                var holder = String(markString[markStringIndex!...])
                                holder = String(holder.dropFirst().dropFirst().dropLast())
                                if Double(holder) != nil {
                                    mark = Double(holder)!
                                }
                                else {
                                    mark = -1.0
                                }
                            }
                            
//                            if markString.count >= 15 {
//                                let markStringIndex = markString.index(markString.startIndex, offsetBy: 15)
//                                var holder = String(markString[markStringIndex...])
//                                if holder.count <= 6 {
//                                    holder = String(holder.dropLast())
//                                    mark = Double(holder)!
//                                }
//                                else {
//                                    mark = -1
//                                }
//                            }
                            else {
                                mark = -1
                            }
                            
                            print(link)
                            
                            let course = Course(code: code, name: name, period: period, room: room, link: link, parsedMark: mark)
                            courses.append(course) //Add all parsed info into the array
                        }
                    }
                }
            }
        
        }
        self.courses = courses
    }
}
