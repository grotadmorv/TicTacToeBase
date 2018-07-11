//
//  TTSocket.swift
//  tictactoe
//
//  Created by SUP'Internet 10 on 27/06/2018.
//  Copyright © 2018 SUP'Internet 02. All rights reserved.
//

import Foundation
import SocketIO

class TTSocket{
    static let sharedInstance = TTSocket()
    let socket = SocketIOClient(socketURL: URL(string: "http://51.254.112.146:5666")!, config: [])
    func connect(){
        self.socket.connect()
    }
    
    func disconnect(){
        self.socket.disconnect()
    }
}
