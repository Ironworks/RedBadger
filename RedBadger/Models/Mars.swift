//
//  Mars.swift
//  RedBadger
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import Foundation

protocol Planet {
    func locationExists(at point: CGPoint) -> Bool
    func setRobotLost(at point: CGPoint)
    func robotLost(at point: CGPoint) -> Bool
}

class Mars: Planet {
    
    struct GridLocation {
        var robotLost: Bool
    }
    
    var topRight: CGPoint
    var grid: [[GridLocation]]
    
    init(topRight: CGPoint) {
        
        self.topRight = topRight
        grid = [[]]
        
        for _ in 0...Int(topRight.x) {
            var yAxis: [GridLocation] = []
            for _ in 0...Int(topRight.y) {
                yAxis.append(GridLocation(robotLost: false))
            }
            grid.append(yAxis)
        }
        grid.remove(at: 0) //Need to remove empty row created at initialisation.
    }
    
    func setRobotLost(at point: CGPoint) {
        //Check location exists
        if locationExists(at: point) &&
           locationIsEdge(at: point) {
            grid[Int(point.x)][Int(point.y)].robotLost = true
        }
    }
    
    func locationExists(at point: CGPoint) -> Bool {
        return point.x >= 0 &&
               point.x <= topRight.x &&
               point.y >= 0 &&
               point.y <= topRight.y
    }
    
    func robotLost(at point: CGPoint) -> Bool {
        if locationExists(at: point) {
            return grid[Int(point.x)][Int(point.y)].robotLost
        }
        
        return false
    }
    
    private func locationIsEdge(at point: CGPoint) -> Bool {
        return point.x == 0 ||
               point.x == topRight.x ||
               point.y == 0 ||
               point.y == topRight.y
    }
}
