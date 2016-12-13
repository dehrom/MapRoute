//
//  TracksFactory.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import MapKit

class TracksFactory {

    func createTracks(FromPoints model: CoordinatesModel?) -> [TrackModel?] {
        var tracks: [TrackModel] = []
        
        guard let points = model?.getPoints() else {
            return tracks
        }

        var prevPoint = points.first
        var currentPoint: Point?
        for i in 1 ..< points.count {
            currentPoint = points[i]
            
            let track = transformTwoPointsToTrack(startPoint: prevPoint, endPoint: currentPoint)
            tracks.append(track)
            prevPoint = points[i]
        }
        
        return tracks
    }
    
    private func transformTwoPointsToTrack(startPoint: Point!, endPoint: Point!) -> TrackModel {
        let speed = getSpeedForTrack(startPoint: startPoint, endPoint: endPoint)
        let color = resolvePolylineColor(ByTrackSpeed: speed)
        
        return TrackModel(startPoint: startPoint,
                          endPoint: endPoint,
                          speed: speed,
                          color: color)
    }
    
    private func getSpeedForTrack(startPoint: Point, endPoint: Point) -> Int {
        let sum = startPoint.speed! + endPoint.speed!
        let speed = sum / 2
        return speed
    }
    
    private func resolvePolylineColor(ByTrackSpeed speed: Int) -> UIColor {
        let color: UIColor
        
        switch speed {
        case 0 ..< 60:
            color = UIColor.green
        case 60 ..< 120:
            color = UIColor.yellow
        case 120 ..< Int.max:
            color = UIColor.red
        default:
            color = UIColor.clear
        }
        
        return color
    }
    
}
