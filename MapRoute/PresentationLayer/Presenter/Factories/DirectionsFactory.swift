//
//  DirectionsFactory.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class DirectionsFactory {
    
    func createDirections(ByTracks tracks: [TrackModel?]) -> [(directions: MKDirections?, color: UIColor?)] {
        return tracks.flatMap { (item: TrackModel?) -> (direction: MKDirections?, color: UIColor?) in
            let directions = createDirections(ByTrack: item)
            return (directions, item?.color)
        }
    }
    
    private func createDirections(ByTrack track: TrackModel?) -> MKDirections? {
        if let directionsRequest = createDirectionRequest(ByTrack: track) {
            return MKDirections(request: directionsRequest)
        } else {
            return nil
        }
    }
    
    private func createDirectionRequest(ByTrack track: TrackModel?) -> MKDirectionsRequest? {
        guard let track = track else {
            return nil
        }
        
        let directionsRequest = MKDirectionsRequest()
        
        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(track.startPoint.lat!),
                                                                             longitude: CLLocationDegrees(track.startPoint.lng!)))
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        
        let destPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(track.endPoint.lat!),
                                                                           longitude: CLLocationDegrees(track.endPoint.lng!)))
        let destMapItem = MKMapItem(placemark: destPlaceMark)
        
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destMapItem
        directionsRequest.transportType = .automobile
        
        return directionsRequest
    }
    
}
