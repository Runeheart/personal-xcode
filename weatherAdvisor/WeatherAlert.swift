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
    
    var event = ""
    var expires = ""
    var summary = ""
    var effective = ""
    var urgency = ""
    var severity = ""
    var certainty = ""
    var link = ""
    var polygon = ""
    
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
    
}
