//
//  ViewController.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import UIKit

class StateViewController: UIViewController {

    var stateData: Dictionary<String, String> = Dictionary<String, String>()
    var states: [String] = []
    var abbvs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "States", ofType: "plist") {
            if let data = NSDictionary(contentsOfFile: path) {
                stateData = data.object(forKey: "States") as! Dictionary<String, String>
                for (key, _) in stateData {
                    states.append(key)
                }
                states.sort()
                for s in states {
                    abbvs.append(stateData[s]!)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.states.count;
    }
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel?.text = states[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.performSegue(withIdentifier: "stateSegue", sender: indexPath);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? AlertViewController
        let index = ((sender as! IndexPath) as NSIndexPath).row;
        destination?.stateName = abbvs[index]
    }

}

