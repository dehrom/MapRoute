//
//  AnnotationsFactory.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class AnnotationsFactory {

    func createAnnotations(FromPoints model: CoordinatesModel?) -> [MKAnnotation]? {
        return model?.getPoints().flatMap({ (item: Point) -> MKAnnotation? in
            return createAnnotation(FromPoint: item)
        })
    }
    
    private func createAnnotation(FromPoint point: Point?) -> MKAnnotation? {
        guard let point = point else {
            return nil
        }
        
        let annotation = MKPointAnnotation()
        let c = point.coordinate
        annotation.coordinate = c
        annotation.title = String(format: "lat: %f, lng: %f", c.latitude, c.longitude)
        return annotation
    }
    
}
