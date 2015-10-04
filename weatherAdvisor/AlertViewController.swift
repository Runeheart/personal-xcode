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
    var entryFound: Bool = false
    var eventFound: Bool = false
    var expiresFound: Bool = false
    var summaryFound: Bool = false
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
        if (elementName == "entry") {
            entryFound = true
            base = WeatherAlert()
        }
        if (elementName == "cap:event") {
            eventFound = true
        }
        if (elementName == "cap:expires") {
            expiresFound = true
        }
        if (elementName == "summary") {
            summaryFound = true
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "entry") {
            entryFound = false
            alerts.append(base)
        }
        if (elementName == "cap:event") {
            eventFound = false
        }
        if (elementName == "cap:expires") {
            expiresFound = false
        }
        if (elementName == "summary") {
            summaryFound = false
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if (eventFound) {
            base.setEvent(string)
        }
        if (expiresFound) {
            base.setExpires(string)
        }
        if (summaryFound) {
            if(string == base.defSummary) {
                base.setEvent(string)
                base.setExpires("")
            }
        }
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return alerts.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
        cell.textLabel?.text = alerts[indexPath.row].event
        cell.detailTextLabel?.text = alerts[indexPath.row].expires
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
