//
//  DependecyAssembly.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import Dip
import Dip_UI

func configureContainer(container: DependencyContainer) {
    Dip.logLevel = .Verbose

    container.register(.singleton) { DataProvider() }
    container.register(.singleton) { JSONToCoordinateModelMapper() }
    container.register(.singleton) { JSONToPointMapper() }
    
    container.register(.singleton) { CoordinatesService() }.resolvingProperties({ (container, service) in
        service.provider = try! container.resolve()
        service.coordinateModelMapper = try! container.resolve()
        service.pointMapper = try! container.resolve()
    })
    
    container.register(factory: PresenterStateStore.init)
    container.register(factory: DirectionsFactory.init)
    container.register(factory: CameraCoordinateFactory.init)
    container.register(factory: TracksFactory.init)
    container.register(factory: AnnotationsFactory.init)
    container.register(factory: PresenterStateStore.init)
    
    container.register { CoordinatesPresenter() }.resolvingProperties({ (container, presenter) in
        presenter.view = try! container.resolve(tag: MapViewController.className())
        presenter.interactor = try! container.resolve()
        presenter.stateStore = try! container.resolve()
        presenter.tracksFactory = try! container.resolve()
        presenter.directionsFactory = try! container.resolve()
        presenter.annotationsFactory = try! container.resolve()
        presenter.cameraCoordinateFactory = try! container.resolve()
    })
    
    container.register { CoordinatesInteractor() }.resolvingProperties({ (container, interactor) in
        interactor.service = try! container.resolve()
        interactor.presenter = try! container.resolve()
    })
    
    container.register(tag: MapViewController.className()) { MapViewController() }
        .resolvingProperties({ (container, controller) in
            controller.presenter = try! container.resolve()
        })
    
    DependencyContainer.uiContainers = [container]
}

extension MapViewController: StoryboardInstantiatable {
}

extension MapViewController {
    
    static func className() -> String {
        return String(describing: self)
    }
    
}
