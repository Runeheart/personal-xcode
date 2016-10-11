//
//  WeatherAlert.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import Foundation

class WeatherAlert {
    
    let defSummary: String = "There are no active watches, warnings or advisories"
    
    var event = "", expires = "", summary = "", effective = "", urgency = ""
    var severity = "", certainty = "", link = "", points = ""
    var dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.medium
    }
    
    func setEvent(_ incEvent: String) {
        self.event = incEvent
    }
    
    func setExpires(_ incExpires: String) {
        if (incExpires != "") {
            let expireDate: Date = getDateAndTimeFrom(incExpires)
            self.expires = "Expires at: " + dateFormatter.string(from: expireDate)
        }
    }
    
    func getDateAndTimeFrom(_ dateString: String) -> Date {
        let expireTimestamp: [String] = dateString.components(separatedBy: "T")
        let dateSection: String = expireTimestamp[0]
        let datePieces: [String] = dateSection.components(separatedBy: "-")
        var expireComponents = DateComponents()
        expireComponents.year = Int(datePieces[0])!
        expireComponents.month = Int(datePieces[1])!
        expireComponents.day = Int(datePieces[2])!
        let timeString: String = expireTimestamp[1]
        let timePieces: [String] = timeString.components(separatedBy: "-")
        let timestamp: [String] = timePieces[0].components(separatedBy: ":")
        expireComponents.hour = Int(timestamp[0])!
        expireComponents.minute = Int(timestamp[1])!
        expireComponents.second = Int(timestamp[2])!
        let finalDate = Calendar.current.date(from: expireComponents)
        return finalDate!
    }
    
    func setSummary(_ incSummary: String) {
        self.summary = incSummary
    }
    
    func setEffective(_ incEffective: String) {
        if (incEffective != "") {
            let effectiveDate: Date = getDateAndTimeFrom(incEffective)
            self.effective = "Effective from: " + dateFormatter.string(from: effectiveDate)
        }
    }
    
    func setUrgency(_ incUrgency: String) {
        self.urgency = incUrgency
    }
    
    func setSeverity(_ incSeverity: String) {
        if (incSeverity != "") {
            self.severity = incSeverity
        }
    }
    
    func setCertainty(_ incCertainty: String) {
        self.certainty = incCertainty
    }
    
    func setLink(_ incLink: String) {
        self.link = incLink
    }
    
    func setPoints(_ incPoly: String) {
        self.points = incPoly
    }
    
    
    
}
