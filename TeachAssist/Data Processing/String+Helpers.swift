//
//  String+Helpers.swift
//  TeachAssist
//
//  Created by York Wei on 2021-06-12.
//  Copyright © 2021 York Wei. All rights reserved.
//

import Foundation

extension String {
    
    func contains(_ string: String) -> Bool {
        return self.indexOf(string) != -1
    }
    
    func indexOf(_ string: String) -> Int {
        return self.range(of: string)?.lowerBound.utf16Offset(in: self) ?? -1
    }
    
    func substring(_ startIndex: Int, _ endIndex: Int? = nil) -> String {
        let endIndex = endIndex ?? self.count
        if startIndex < 0 || startIndex > endIndex || endIndex > self.count {
            return ""
        }
        return String(self[self.index(self.startIndex, offsetBy: startIndex)..<self.index(self.startIndex, offsetBy: endIndex)])
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func split(_ separator: String) -> [String] {
        return self.components(separatedBy: separator)
    }
    
    func toDouble() -> Double {
        return Double(self) ?? -1
    }
    
}
