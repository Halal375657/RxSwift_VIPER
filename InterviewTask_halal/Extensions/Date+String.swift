//
//  Date+String.swift
//  InterviewTask_halal
//
//  Created by iOS on 14/9/22.
//

import Foundation

extension Date {

    func toString(withFormat format: String = "d MMMM yyyy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        //dateFormatter.calendar = Calendar(identifier: .persian)
        
        let str = dateFormatter.string(from: self)

        return str
    }
}
