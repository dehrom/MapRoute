//
//  JSONToPointMapper.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONToPointMapper: IMapper {
    
    typealias T = JSON
    typealias R = Point
    
    func transform(Model model: JSON?) -> Point {
        return Point(lat: model?["lat"].floatValue,
                     lng: model?["lng"].floatValue,
                     date: model?["date"].doubleValue,
                     speed: model?["speed"].intValue)
    }
    
}
