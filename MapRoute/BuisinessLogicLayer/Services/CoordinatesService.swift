//
//  CoordinatesService.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 24.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias CoordinatesServiceCompletionHandler = (CoordinatesModel?) -> Void

class CoordinatesService {
    
    var provider: DataProvider!
    var coordinateModelMapper: JSONToCoordinateModelMapper!
    var pointMapper: JSONToPointMapper!
    
    func loadCoordinates(handler: @escaping CoordinatesServiceCompletionHandler) {
        provider.loadData { (data: Data?) in
            guard let data = data else {
                handler(nil)
                return
            }
            
            let jsonData = JSON(data: data)
            let dataSection = jsonData.dictionaryValue["data"]?.array?.first?.dictionaryValue
            
            let coordinatesModel = coordinateModelMapper.transform(Model: dataSection)
            
            let pointsArray = dataSection?["points"]?.arrayValue
            
            for json: JSON in pointsArray! {
                let point = pointMapper.transform(Model: json)
                coordinatesModel.addPoint(point: point)
            }
        
            handler(coordinatesModel)
        }
    }
    
}
