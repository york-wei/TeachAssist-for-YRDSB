//
//  Evaluation.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-17.
//  Copyright © 2020 York Wei. All rights reserved.
//

import Foundation

class Evaluation : Codable, Equatable, Identifiable, ObservableObject {
    
    static func == (lhs: Evaluation, rhs: Evaluation) -> Bool {
        return lhs.name == rhs.name && lhs.overall == rhs.overall
    }
    
    var deleted : Bool
    
    var id = UUID()
    
    var name : String

    var k : Double
    var kWeight : Double
    var kScore : String
    
    var t : Double
    var tWeight : Double
    var tScore : String
    
    var c : Double
    var cWeight : Double
    var cScore : String

    var a : Double
    var aWeight : Double
    var aScore : String
    
    var o : Double
    var oWeight : Double
    var oScore : String
    
    var overall : Double
    
    init(name: String, k: Double, kWeight: Double, kScore: String, t: Double, tWeight : Double, tScore: String, c: Double, cWeight : Double, cScore: String, a: Double, aWeight : Double, aScore: String, o: Double, oWeight : Double, oScore: String, overall: Double) {
        
        self.name = name
        
        self.k = k
        self.kWeight = kWeight
        self.kScore = kScore
        
        self.t = t
        self.tWeight = tWeight
        self.tScore = tScore
        
        self.c = c
        self.cWeight = cWeight
        self.cScore = cScore
        
        self.a = a
        self.aWeight = aWeight
        self.aScore = aScore
        
        self.o = o
        self.oWeight = oWeight
        self.oScore = oScore
        
        self.overall = overall
        
        self.deleted = false
        
    }

}
