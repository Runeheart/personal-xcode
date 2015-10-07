//
//  AlertDetailsViewController.swift
//  weatherAdvisor
//
//  Created by Jonah Austin on 10/3/15.
//  Copyright © 2015 Jonah Austin. All rights reserved.
//

import UIKit
import MapKit

class AlertDetailsViewController: UIViewController, MKMapViewDelegate {

    var alert: WeatherAlert = WeatherAlert()
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var summaryTxtView: UITextView!
    @IBOutlet weak var effectiveLabel: UILabel!
    @IBOutlet weak var expiresLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var severityLabel: UILabel!
    @IBOutlet weak var certaintyLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var polyMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.text = alert.event
        summaryTxtView.text = alert.summary
        summaryTxtView.backgroundColor = (alert.event == "There are no active alerts" ? UIColor.whiteColor() : UIColor.cyanColor())
        effectiveLabel.text = alert.effective
        expiresLabel.text = alert.expires
        urgencyLabel.text = (alert.urgency == "" ? "" : "Urgency: ") + alert.urgency
        severityLabel.text = (alert.severity == "" ? "" : "Severity: ") + alert.severity
        certaintyLabel.text = (alert.certainty == "" ? "" : "Certainty: ") + alert.certainty
        linkLabel.text = "Link: " + alert.link
        if (alert.points != "") {
            polyMap.delegate = self
            configureMapView()
        }
    }
    
    func configureMapView() {
        let coords: [String] = alert.points.componentsSeparatedByString(" ")
        let centerPoint = findCenterPointFrom(coords)
        let span = MKCoordinateSpanMake(0.75, 0.75)
        let region = MKCoordinateRegionMake(centerPoint, span)
        polyMap.setRegion(region, animated: true)
        var clCoords: [CLLocationCoordinate2D] = makeClCoordsFrom(coords)
        let poly = MKPolygon(coordinates: &clCoords, count: coords.count)
        polyMap.addOverlay(poly)
    }
    
    func findCenterPointFrom(coordinates: [String]) -> CLLocationCoordinate2D {
        var centerLatitude: Double = 0.0, centerLongitude: Double = 0.0
        for ordPair in coordinates {
            let latLon: [String] = ordPair.componentsSeparatedByString(",")
            centerLatitude += Double(latLon[0])!
            centerLongitude += Double(latLon[1])!
        }
        let numPoints: Double = Double(coordinates.count)
        centerLatitude = centerLatitude / numPoints
        centerLongitude = centerLongitude / numPoints
        return CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
    }
    
    func makeClCoordsFrom(pairs: [String]) -> [CLLocationCoordinate2D] {
        var cLocations: [CLLocationCoordinate2D] = []
        for ordPair in pairs {
            var temp: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.0, longitude: 2.0)
            let latLon: [String] = ordPair.componentsSeparatedByString(",")
            temp.latitude = Double(latLon[0])!
            temp.longitude = Double(latLon[1])!
            cLocations.append(temp)
        }
        return cLocations
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.magentaColor()
            polygonView.lineWidth = 2.0
            return polygonView
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
