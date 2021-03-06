//
//  AlertViewController.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, XMLParserDelegate {

    var stateName = String()
    var alerts: [WeatherAlert] = []
    var base: WeatherAlert = WeatherAlert()
    var entryFound: Bool = false, eventFound: Bool = false, expiresFound: Bool = false
    var summaryFound: Bool = false, effectiveFound: Bool = false
    var urgencyFound: Bool = false, severityFound: Bool = false
    var certaintyFound: Bool = false, polyFound: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://alerts.weather.gov/cap/" + stateName + ".php?x=0")
        let xmlParser = XMLParser(contentsOf: url!)
        xmlParser?.delegate = self
        xmlParser?.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if (elementName == "link") {
            let link: String = attributeDict["href"]!
            base.setLink(link)
        } else {
            configureBooleanBasedOn(elementName)
        }
    }
    
    func configureBooleanBasedOn(_ element: String) {
        switch(element) {
        case "entry":
            entryFound = entryFound ? false : true
            if entryFound {
                base = WeatherAlert()
            } else {
                alerts.append(base)
            }
            break
        case "cap:event":
            eventFound = eventFound ? false : true
            break
        case "cap:expires":
            expiresFound = expiresFound ? false : true
            break
        case "summary":
            summaryFound = summaryFound ? false : true
            break
        case "cap:effective":
            effectiveFound = effectiveFound ? false : true
            break
        case "cap:urgency":
            urgencyFound = urgencyFound ? false : true
            break
        case "cap:severity":
            severityFound = severityFound ? false : true
            break
        case "cap:certainty":
            certaintyFound = certaintyFound ? false : true
            break
        case "cap:polygon":
            polyFound = polyFound ? false : true
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        configureBooleanBasedOn(elementName)
    }
    
    func parser(_ parser: XMLParser, foundCharacters tagValue: String) {
        if (eventFound) {
            base.setEvent(tagValue)
        } else if (expiresFound) {
            base.setExpires(tagValue)
        } else if (summaryFound) {
            if(tagValue == base.defSummary) {
                base.setEvent("There are no active alerts")
                base.setExpires("")
            } else {
                base.setSummary(tagValue)
            }
        } else if (effectiveFound) {
            base.setEffective(tagValue)
        } else if (urgencyFound) {
            base.setUrgency(tagValue)
        } else if (severityFound) {
            base.setSeverity(tagValue)
        } else if (certaintyFound) {
            base.setCertainty(tagValue)
        } else if (polyFound) {
            base.setPoints(tagValue)
        }
    }
    
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return alerts.count;
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:"cell")
        let givenAlert: WeatherAlert = alerts[indexPath.row]
        cell.textLabel?.text = givenAlert.event
        cell.detailTextLabel?.text = givenAlert.expires
        cell.backgroundColor = determineBackgroundColorFrom(givenAlert.severity)
        return cell
    }
    
    func determineBackgroundColorFrom(_ severity: String) -> UIColor {
        switch(severity) {
        case "Extreme":
            return UIColor.red
        case "Severe":
            return UIColor.orange
        case "Moderate":
            return UIColor.yellow
        default:
            return UIColor.white
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.performSegue(withIdentifier: "alertSegue", sender: indexPath);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? AlertDetailsViewController
        let index = ((sender as! IndexPath) as NSIndexPath).row;
        destination?.alert = alerts[index]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
