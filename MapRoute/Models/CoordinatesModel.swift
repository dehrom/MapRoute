//
//  CoordinatesModel.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 25.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class CoordinatesModel {
    private var pointsArray: [Point] = []
    
    let start: Double?
    let end: Double?
    let length: Int?
    
    var count: Int? {
        get {
            return pointsArray.count
        }
    }
    
    let maxSpeed: Int?
    
    init(start: Double?, end: Double?, length: Int?, maxSpeed: Int?) {
        self.start = start
        self.end = end
        self.length = length
        self.maxSpeed = maxSpeed
    }
    
    func addPoint(point: Point) {
        pointsArray.append(point)
    }
    
    func removePoint(point: Point) {
        pointsArray.remove(at: pointsArray.index(of: point)!)
    }
    
    func getPoints() -> [Point] {
        return Array(pointsArray)
    }
    
}

class Point: NSObject, MKAnnotation {
    let lat: Float?
    let lng: Float?
    let date: Double?
    let speed: Int?
    let color: UIColor?
    
    override var hashValue: Int {
        get {
            return "\(lat),\(lng),\(date),\(speed)".hashValue
        }
    }
    
    init(lat: Float?, lng: Float?, date: Double?, speed: Int?) {
        self.lat = lat
        self.lng = lng
        self.date = date
        self.speed = speed
        self.color = UIColor.green
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lng!))
        }
    }
    
}
