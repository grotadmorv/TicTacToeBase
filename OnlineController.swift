//
//  OnlineController.swift
//  tictactoe
//
//  Created by SUP'Internet 10 on 27/06/2018.
//  Copyright © 2018 SUP'Internet 02. All rights reserved.
//

import UIKit

class OnlineController: UIViewController {
    
    @IBOutlet weak var playerAdverse: UITextField!
    @IBOutlet weak var playerTurn: UITextField!
    @IBOutlet weak var winnerText: UITextField!
    var data: Any?
    var turn: String = ""
    var playerX: String = ""
    var playerO: String = ""
    
    @IBAction func handleClick(_ sender: UIButton) {
        if((self.turn == "o" && self.playerO == "grota") || (self.turn == "x" && self.playerX == "grota")){
            if(self.playerO == "grota"){
                sender.setImage(UIImage(named: "O.png"), for: .normal)
            }else{
                sender.setImage(UIImage(named: "cross.png"), for: .normal)
            }
            TTSocket.sharedInstance.socket.emit("movement", (sender.tag) )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let paramsArray = data as! NSArray
        let unwrappedDictJson = paramsArray[0] as! [String: Any]
        print(unwrappedDictJson)
        playerX = unwrappedDictJson["playerX"]! as! String
        playerO = unwrappedDictJson["playerO"]! as! String

        playerAdverse.font = UIFont(name: "MarkerFelt-Wide", size: 22)
        winnerText.font = UIFont(name: "MarkerFelt-Wide", size: 22)
        playerTurn.font = UIFont(name: "MarkerFelt-Wide", size: 22)
        if(playerX == "grota"){
            playerAdverse.text = "You play with \(playerO)"
        }else{
            playerAdverse.text = "You play with \(playerX)"
        }
        
        turn = unwrappedDictJson["currentTurn"]! as! String
        checkTurn(param: turn)
        
        TTSocket.sharedInstance.socket.on("movement", callback: { (data, ack) in
            let tmpJson = data as! NSArray
            let jsonParsed = tmpJson[0] as! [String: Any]
            print(jsonParsed)
            self.turn = jsonParsed["player_play"]! as! String
            self.checkTurn(param: self.turn)
            if( (jsonParsed["player_played"]! as! String == "x" && self.playerX == "grota2") || (self.playerO == "grota2" && jsonParsed["player_played"]! as! String == "o" )){
                let tmpTag = jsonParsed["index"]! as! Int
                let imgToPut = self.view .viewWithTag(tmpTag) as? UIButton
                if(self.playerX == "grota2"){
                    imgToPut?.setImage(UIImage(named: "cross.png"), for: .normal)
                }else{
                    imgToPut?.setImage(UIImage(named: "O.png"), for: .normal)
                }
            }
            print(jsonParsed)
            if(jsonParsed["win"] != nil){
                let win = jsonParsed["win"]! as! Bool
                if(win == true){
                    if(jsonParsed["player_played"] as! String == self.playerX){
                        self.winnerText.text = "\(self.playerX) win the game !"

                    }else{
                        self.winnerText.text = "\(self.playerO) win the game !"
                    }
                }
                
                
            }
        })
    }
    
    
    func checkTurn(param: String){
        if((param == "x" && self.playerX == "grota") || (param == "o" && self.playerO == "grota") ){
            playerTurn.text = "It's your turn"
        }else{
            playerTurn.text = "Opponent turn"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

