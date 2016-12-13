//
//  ViewController.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 24.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class MapViewController: UIViewController {
    
    var presenter: CoordinatesPresenter!

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        presenter.view = self
    }
    
    @IBAction func tapInfoButton(_ sender: AnyObject) {
        presenter.didTapGetInfoAboutRouteButton()
    }
    
    func showInfoAboutRoute(model: RouteInformationModel) {
        let alertViewController = UIAlertController(title: "Information", message: model.infoAsString, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.show(alertViewController, sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.mapDidAppear()
    }
    
    public func setAnnotations(annotations: [MKAnnotation]?) {
        guard let annotations = annotations else {
            return
        }
        mapView.showAnnotations(annotations, animated: true)
    }
    
    public func setViewModels(viewModels: [Point]?) {
        guard let viewModels = viewModels else {
            return
        }
        mapView.addAnnotations(viewModels)
    }
    
    public func setPolyline(polyline: MKPolyline?) {
        guard let polyline = polyline else {
            return
        }
        mapView.add(polyline)
    }
    
    public func setCameraPosition(coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            return
        }
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 12000, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: true)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = (overlay as? CustomPolyline)?.color
        renderer.lineWidth = 4.0
        
        return renderer
    }

}

