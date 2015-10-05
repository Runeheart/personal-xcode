//
//  ViewController.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import UIKit

class StateViewController: UIViewController {

    var stateData: Dictionary = Dictionary<String, String>()
    var states: [String] = []
    var abbvs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = NSBundle.mainBundle().pathForResource("States", ofType: "plist") {
            if let data = NSDictionary(contentsOfFile: path) {
                stateData = data.objectForKey("States") as! Dictionary<String, String>
                for (key, _) in stateData {
                    states.append(key)
                }
                states.sortInPlace()
                for s in states {
                    abbvs.append(stateData[s]!)
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.states.count;
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        cell.textLabel?.text = states[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("stateSegue", sender: indexPath);
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as? AlertViewController
        let index = (sender as! NSIndexPath).row;
        destination?.stateName = abbvs[index]
    }

}

