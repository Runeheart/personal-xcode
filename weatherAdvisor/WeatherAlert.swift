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
    
    init() {}
    
    func setEvent(incEvent: String) {
        self.event = incEvent
    }
    
    func setExpires(incExpires: String) {
        self.expires = incExpires
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
