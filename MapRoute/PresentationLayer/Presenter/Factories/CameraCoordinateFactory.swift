//
//  CameraCoordinateFactory.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class CameraCoordinateFactory {
    
    func createCameraCoordinateLocation(model: CoordinatesModel?) -> CLLocationCoordinate2D? {
        guard let model = model else {
            return nil
        }
        
        var deltaLat: Float = 0
        var deltaLng: Float = 0
        
        model.getPoints().enumerated().forEach { (item: (offset: Int, element: Point)) in
            deltaLat = deltaLat + item.element.lat!
            deltaLng = deltaLng + item.element.lng!
        }
        
        deltaLat = deltaLat / Float(model.count!)
        deltaLng = deltaLng / Float(model.count!)
        
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(deltaLat),
                                      longitude: CLLocationDegrees(deltaLng))
    }
    
}
