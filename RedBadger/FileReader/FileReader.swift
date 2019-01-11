//
//  FileReader.swift
//  RedBadger
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

//Class to read input file from main bundle

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

class FileReader {
    
    let fileName: String
    let fileType: String
    
    init(fileName: String, type: String) {
        self.fileName = fileName
        self.fileType = type
    }
    
    func readFile() -> Commands? {
        let bundle  = Bundle(for: type(of: self))
        
        
        guard let url = bundle.url(forResource: fileName, withExtension: fileType) else {
            return nil
        }
        
        let commandString = try? String(contentsOf: url)
        let commandsArray = commandString?.split(separator: "\n")
        
        let gridString = String(commandsArray![0])
        let grid = point(from: gridString)
        
        var robotCommands: [RobotCommand] = []
        var directions: [String]
        var startPoint = CGPoint(x: 0, y: 0)
        var startOrientation = Orientation.north
        for i in 1...(commandsArray?.count)! - 1 {

            if i % 2 == 0 {
                //Even so must be directions
                directions = String(commandsArray![i]).map { String ($0) }
                let robotCommand = RobotCommand(startPoint: startPoint, startOrientation: startOrientation, moves: directions)
                robotCommands.append(robotCommand)
            } else {
                let s = String(commandsArray![i]).split(separator: " ")
                startPoint = point(from: s[0] + " " + s[1])
                startOrientation = Orientation.orientation(from: String(s[2]))
            }
        }
        
        return Commands(gridSize: grid, robotCommands: robotCommands)
        
    }
    
    private func point(from string: String) -> CGPoint {
        
        let gridSizeArray = string.split(separator: " ")
        
        guard let x = Int(String(gridSizeArray[0])),
            let y = Int(String(gridSizeArray[1])) else {
                return CGPoint(x: 0, y: 0)
        }
        
        return CGPoint(x: x, y: y)
        
    }
    

}
