//
//  main.swift
//  RedBadger
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import Foundation

func processCommands(commands: Commands) {
    //Create Mars
    let planet = Mars(topRight: commands.gridSize)
    
    for robotCommand in commands.robotCommands {
        //Create a robot
        let robot = Robot(planet: planet, position: robotCommand.startPoint, orientation: robotCommand.startOrientation)
        for instruction in robotCommand.moves {
            robot.execute(instruction: Instruction.instructionFromString(string: instruction))
        }
        print (robot.status())
    }
}


//Create fileReader
let fileReader = FileReader(fileName: "input", type: "txt")

//Initialise commands
var commands: Commands

//Read file
do {
    commands = try fileReader.readFile()
    processCommands(commands: commands)

} catch let error {
    //In the event of failure print error
    print(error)
}





