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
    var dateFormatter = NSDateFormatter()
    
    init() {
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
    }
    
    func setEvent(incEvent: String) {
        self.event = incEvent
    }
    
    func setExpires(incExpires: String) {
        if (incExpires != "") {
            let expireTimestamp: [String] = incExpires.componentsSeparatedByString("T")
            let dateString: String = expireTimestamp[0]
            let datePieces: [String] = dateString.componentsSeparatedByString("-")
            let expireComponents = NSDateComponents()
            expireComponents.year = Int(datePieces[0])!
            expireComponents.month = Int(datePieces[1])!
            expireComponents.day = Int(datePieces[2])!
            let timeString: String = expireTimestamp[1]
            let timePieces: [String] = timeString.componentsSeparatedByString("-")
            let timestamp: [String] = timePieces[0].componentsSeparatedByString(":")
            expireComponents.hour = Int(timestamp[0])!
            expireComponents.minute = Int(timestamp[1])!
            expireComponents.second = Int(timestamp[2])!
            let expireDate = NSCalendar.currentCalendar().dateFromComponents(expireComponents)
            expires = "Expires at: " + dateFormatter.stringFromDate(expireDate!)
            
        }
    }
    
    func setSummary(incSummary: String) {
        self.summary = incSummary
    }
    
    func setEffective(incEffective: String) {
        self.effective = incEffective
    }
    
    func setUrgency(incUrgency: String) {
        self.urgency = incUrgency
    }
    
    func setSeverity(incSeverity: String) {
        self.severity = incSeverity
    }
    
    func setCertainty(incCertainty: String) {
        self.certainty = incCertainty
    }
    
    func setLink(incLink: String) {
        self.link = incLink
    }
    
    func setPoints(incPoly: String) {
        self.points = incPoly
    }
    
    
    
}
