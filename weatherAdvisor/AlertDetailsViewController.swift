//
//  AlertDetailsViewController.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import UIKit

class AlertDetailsViewController: UIViewController {

    var alert: WeatherAlert = WeatherAlert()
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var summaryTxtView: UITextView!
    @IBOutlet weak var effectiveLabel: UILabel!
    @IBOutlet weak var expiresLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var severityLabel: UILabel!
    @IBOutlet weak var certaintyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.text = alert.event
        summaryTxtView.text = alert.summary
        effectiveLabel.text = alert.effective
        expiresLabel.text = alert.expires
        urgencyLabel.text = (alert.urgency == "" ? "" : "Urgency: ") + alert.urgency
        severityLabel.text = "Severity: " + alert.severity
        certaintyLabel.text = "Certainty: " + alert.certainty
        // Do any additional setup after loading the view.
    }
  

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
