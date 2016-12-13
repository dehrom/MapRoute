//
//  JSONToCoordinateModelMapper.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONToCoordinateModelMapper: IMapper {
    typealias T = [String: JSON]
    typealias R = CoordinatesModel
    
    func transform(Model model: Dictionary<String, JSON>?) -> CoordinatesModel {
        return CoordinatesModel(start: model?["start"]?.doubleValue,
                                end: model?["end"]?.doubleValue,
                                length: model?["length"]?.intValue,
                                maxSpeed: model?["max_speed"]?.intValue)
    }
    
}
