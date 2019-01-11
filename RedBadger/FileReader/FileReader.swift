//
//  FileReader.swift
//  RedBadger
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

//Class to read input file from main bundle

import Foundation

enum FileReaderErrors: Error {
    case fileNotFound
    case unableToReadFile
    case emptyFile
}

class FileReader {
    
    let fileName: String
    let fileType: String
    
    init(fileName: String, type: String) {
        self.fileName = fileName
        self.fileType = type
    }
    
    func readFile() throws -> Commands  {
        let bundle  = Bundle(for: type(of: self))
        var commandString: String
        
        
        guard let url = bundle.url(forResource: fileName, withExtension: fileType) else {
            throw FileReaderErrors.fileNotFound
        }
        
        do {
            commandString = try String(contentsOf: url)
        } catch {
            throw FileReaderErrors.unableToReadFile
        }

        let commandsArray = commandString.split(separator: "\n")
        if commandsArray.count == 0 {
            throw FileReaderErrors.emptyFile
        }
        
        let gridString = String(commandsArray[0])
        let grid = point(from: gridString)
        
        let commands = robotCommands(from: commandsArray)
        
        return Commands(gridSize: grid, robotCommands: commands)
        
    }
    
    private func robotCommands(from commandArray: [Substring]) -> [RobotCommand] {
        var robotCommands: [RobotCommand] = []
        var directions: [String]
        var startPoint = CGPoint(x: 0, y: 0)
        var startOrientation = Orientation.north
        for i in 1...(commandArray.count) - 1 {
            
            if i % 2 == 0 {
                //Even so must be directions
                directions = String(commandArray[i]).map { String ($0) }
                let robotCommand = RobotCommand(startPoint: startPoint,
                                                startOrientation: startOrientation,
                                                moves: directions)
                robotCommands.append(robotCommand)
            } else {
                let s = String(commandArray[i]).split(separator: " ")
                startPoint = point(from: s[0] + " " + s[1])
                startOrientation = Orientation.orientation(from: String(s[2]))
            }
        }
        
        return robotCommands
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
