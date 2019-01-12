//
//  Robot.swift
//  RedBadger
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import Foundation

enum Instruction {
    case turnLeft
    case turnRight
    case goForward
    case invalid
    
    static func instructionFromString(string: String) -> Instruction {
        switch string {
        case "R":
            return Instruction.turnRight
        case "L":
            return Instruction.turnLeft
        case "F":
            return Instruction.goForward
        default:
            return Instruction.invalid
        }
    }
}

protocol RobotActions {
    func execute(instruction: Instruction)
    func status() -> String
}

class Robot: RobotActions {
    
    private (set) var planet: Planet
    private (set) var orientation: Orientation
    private (set) var lost = false
    private (set) var position: CGPoint
    
    init(planet: Planet, position: CGPoint, orientation: Orientation) {
        self.planet = planet
        self.position = position
        self.orientation = orientation
    }
    
    func execute(instruction: Instruction) {
        
        //Ignore instruction if robot is lost
        if lost {
            return
        }
        
        switch instruction {
        case .turnLeft:
            switch self.orientation {
            case .north:
                orientation = .west
            case .east:
                orientation = .north
            case .south:
                orientation = .east
            case .west:
                orientation = .south
            }
        case .turnRight:
            switch self.orientation {
            case .north:
                orientation = .east
            case .east:
                orientation = .south
            case .south:
                orientation = .west
            case .west:
                orientation = .north
            }
            
        case .goForward:
            moveForward()
            
        case .invalid:
            //If we have an invalid instruction, do nothing
            return
        }
    }

    func status() -> String {
        
        let statusString = String(format: "%.0f", position.x) + " " +
                           String(format: "%.0f", position.y) + " " +
                           orientation.identifierForOrientation()
        
        return lost ? statusString + " " + "LOST" : statusString
    }
    
    private func moveForward() {
        
        var newPosition = position
        
        switch orientation {
        case .north:
            newPosition.y += 1
        case .east:
            newPosition.x += 1
        case .south:
            newPosition.y -= 1
        case .west:
            newPosition.x -= 1
        }
        
        if planet.locationExists(at: newPosition) {
            position = newPosition
        } else if !planet.robotLost(at: newPosition) {
            lost = true
            planet.setRobotLost(at: newPosition)
        }
        
    }
    
}
