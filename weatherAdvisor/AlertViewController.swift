//
//  AlertViewController.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, NSXMLParserDelegate {

    var stateName = String()
    var alerts: [WeatherAlert] = []
    var base: WeatherAlert = WeatherAlert()
    var entryFound: Bool = false, eventFound: Bool = false, expiresFound: Bool = false
    var summaryFound: Bool = false, effectiveFound: Bool = false
    var urgencyFound: Bool = false, severityFound: Bool = false
    var certaintyFound: Bool = false, linkFound: Bool = false, polyFound: Bool = false
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://alerts.weather.gov/cap/" + stateName + ".php?x=0")
        let xmlParser = NSXMLParser(contentsOfURL: url!)
        xmlParser?.delegate = self
        xmlParser?.parse()
        // Do any additional setup after loading the view.
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        configureBooleanBasedOn(elementName)
    }
    
    func configureBooleanBasedOn(element: String) {
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        configureBooleanBasedOn(elementName)
    }
    
    func parser(parser: NSXMLParser, foundCharacters tagValue: String) {
        if (eventFound) {
            base.setEvent(tagValue)
        } else if (expiresFound) {
            base.setExpires(tagValue)
        } else if (summaryFound) {
            if(tagValue == base.defSummary) {
                base.setEvent("There are no active alerts")
                base.setExpires("")
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
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return alerts.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
        let givenAlert: WeatherAlert = alerts[indexPath.row]
        cell.textLabel?.text = givenAlert.event
        cell.detailTextLabel?.text = givenAlert.expires
        cell.backgroundColor = determineBackgroundColorFrom(givenAlert.severity)
        return cell
    }
    
    func determineBackgroundColorFrom(severity: String) -> UIColor {
        switch(severity) {
        case "Extreme":
            return UIColor.redColor()
        case "Severe":
            return UIColor.orangeColor()
        case "Moderate":
            return UIColor.yellowColor()
        default:
            return UIColor.whiteColor()
        }

    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("testSegue", sender: indexPath);
//    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destination = segue.destinationViewController as? AlertDetailsViewController
//        let index = (sender as! NSIndexPath).row;
//        destination?.stateName = abbvs[index]
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
