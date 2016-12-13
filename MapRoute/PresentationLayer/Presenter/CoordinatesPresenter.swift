//
//  CoordinatesPresenter.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 25.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class CoordinatesPresenter {
    
    var interactor: CoordinatesInteractor!
    var stateStore: PresenterStateStore!
    var tracksFactory: TracksFactory!
    var directionsFactory: DirectionsFactory!
    var cameraCoordinateFactory: CameraCoordinateFactory!
    var annotationsFactory: AnnotationsFactory!
    
    weak var view: MapViewController?
    
    func mapDidAppear() {
        interactor.loadCoordinates()
    }
    
    func didTapGetInfoAboutRouteButton() {
        view?.showInfoAboutRoute(model: stateStore.routeModel)
    }
    
}

extension CoordinatesPresenter {

    // Обработка поступивших данных и отображение маршрута
    func coordinatesDidLoad(model: CoordinatesModel?) {
        guard let model = model else {
            print("Ошибка загрузки данных")
            return
        }
        
        storeInformationAboutRoute(model: model)
        view?.setCameraPosition(coordinate: (cameraCoordinateFactory.createCameraCoordinateLocation(model: model)))
        view?.setViewModels(viewModels: model.getPoints())
        view?.setAnnotations(annotations: (annotationsFactory.createAnnotations(FromPoints: model)))
        resolveRoutes(FromModel: model)
    }
    
}

extension CoordinatesPresenter {
    
    // Определение маршрута по координатам точек
    internal func resolveRoutes(FromModel model: CoordinatesModel) {
        let tracks = tracksFactory.createTracks(FromPoints: model)
        let directions = directionsFactory.createDirections(ByTracks: tracks)
        interactor.resolveRoutes(ByDirections: directions)
    }
    
    func routesDidResolved(polyline: MKPolyline?, error: Error?) {
        if error != nil {
            print("Ошибка расчета маршрута: \(error)")
        } else {
            self.view?.setPolyline(polyline: polyline)
        }
    }

}

extension CoordinatesPresenter {

    // Сохрание данных о маршруте
    internal func storeInformationAboutRoute(model: CoordinatesModel) {
        let length = String(describing: model.length! / 1000)
        let maxSpeed = String(describing: model.maxSpeed!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: model.start!))
        let startTime = dayFormatter.string(from: Date(timeIntervalSince1970: model.start!))
        let endTime = dayFormatter.string(from: Date(timeIntervalSince1970: model.end!))
        
        stateStore.routeModel = RouteInformationModel(length: length,
                                                      maxSpeed: maxSpeed,
                                                      date: date,
                                                      startTime: startTime,
                                                      endTime: endTime)
    }
    
}
