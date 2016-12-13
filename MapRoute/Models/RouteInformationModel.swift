//
//  RouteInformationModel.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

struct RouteInformationModel {
    
    let length: String!
    let maxSpeed: String!
    let date: String!
    let startTime: String!
    let endTime: String!
    
    var infoAsString: String {
        get {
            return "Route length: \(length!) km \n Max Speed: \(maxSpeed!) km/h \n Date: \(date!) \(startTime!)-\(endTime!) "
        }
    }
    
}
