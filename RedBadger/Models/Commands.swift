//
//  Commands.swift
//  RedBadger
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import Foundation

enum Orientation {
    case north
    case east
    case south
    case west
    
    static func orientation(from string: String) -> Orientation {
        
        switch string {
        case "N":
            return Orientation.north
        case "E":
            return Orientation.east
        case "S":
            return Orientation.south
        case "W":
            return Orientation.west
        default:
            return Orientation.north
        }
    }
    
    func identifierForOrientation() -> String {
        switch self {
        case .north:
            return "N"
        case .east:
            return "E"
        case .south:
            return "S"
        case .west:
            return "W"
        }
    }
}

struct RobotCommand {
    let startPoint: CGPoint
    let startOrientation: Orientation
    let moves: [String]
}

struct Commands {
    let gridSize: CGPoint
    let robotCommands: [RobotCommand]
}
