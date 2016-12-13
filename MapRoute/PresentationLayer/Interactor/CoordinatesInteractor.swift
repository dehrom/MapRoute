//
//  CoordinatesInteractor.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 25.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class CoordinatesInteractor {
    
    var service: CoordinatesService!
    var presenter: CoordinatesPresenter!
    
}

extension CoordinatesInteractor {

    // Загрузка списка координат из сервиса
    func loadCoordinates() {
        service.loadCoordinates { [weak self] model in
            self?.presenter.coordinatesDidLoad(model: model)
        }
    }
    
}

extension CoordinatesInteractor {

    private typealias RoutesCompletionHandler = (MKPolyline?, Error?) -> Void
    
    // Составление маршрута на основе координат точек
    func resolveRoutes(ByDirections directionsWithColor: [(directions: MKDirections?, color: UIColor?)]) {
        directionsWithColor.forEach { (item: (directions: MKDirections?, color: UIColor?)) in
            calcRoute(WithDirection: item, AndCompletionHandler: { (polyline, error) in
                self.presenter.routesDidResolved(polyline: polyline, error: error)
            })
        }
    }
    
    private func calcRoute(WithDirection directionWithColor: (directions: MKDirections?, color: UIColor?),
                           AndCompletionHandler handler: @escaping RoutesCompletionHandler) {
        guard let directions = directionWithColor.directions else {
            handler(nil, nil)
            return
        }
        
        directions.calculate { (response, error) in
            guard let response = response else {
                if error != nil {
                    handler(nil, error)
                } else {
                    handler(nil, nil)
                }
                return
            }
            
            let route = response.routes[0]
            let polyline = CustomPolyline(points: route.polyline.points(),
                                          count: route.polyline.pointCount)
            polyline.color = directionWithColor.color
            
            handler(polyline, nil)
        }
        
    }
    
}
