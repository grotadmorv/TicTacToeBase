//
//  offlineController.swift
//  tictactoe
//
//  Created by SUP'Internet 02 on 13/06/2018.
//  Copyright © 2018 SUP'Internet 02. All rights reserved.
//

import UIKit

class OfflineController: UIViewController {
    var values: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var playerTurn: Int = 1
    var scoreX: Int = 0
    var scoreO: Int = 0
    
    @IBOutlet weak var scoreTxt: UITextField!
    @IBOutlet weak var winnerText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleClick(_ sender: UIButton) {
        self.winnerText.font = UIFont(name: "MarkerFelt-Wide", size: 30)
        self.scoreTxt.font = UIFont(name: "MarkerFelt-Wide", size: 30)
        self.scoreTxt.text = "X : \(self.scoreX) - O : \(self.scoreO)"
        if(self.playerTurn == 1){
            sender.setImage(UIImage(named: "O.png"), for: .normal)
        }else if(self.playerTurn == 2){
            sender.setImage(UIImage(named: "cross.png"), for: .normal)
        }
        //sender.setTitle(String(self.playerTurn), for: .normal)
        self.values[sender.tag] = self.playerTurn
        
        if(
            (self.values[0] != 0 && self.values[0] == self.values[1] && self.values[1] == self.values[2]) ||
            (self.values[3] != 0 && self.values[3] == self.values[4] && self.values[4] == self.values[5]) ||
            (self.values[6] != 0 && self.values[6] == self.values[7] && self.values[7] == self.values[8]) ||
            (self.values[0] != 0 && self.values[0] == self.values[3] && self.values[3] == self.values[6]) ||
            (self.values[1] != 0 && self.values[1] == self.values[4] && self.values[4] == self.values[7]) ||
            (self.values[2] != 0 && self.values[2] == self.values[5] && self.values[5] == self.values[8]) ||
            (self.values[0] != 0 && self.values[0] == self.values[4] && self.values[4] == self.values[8]) ||
            (self.values[2] != 0 && self.values[2] == self.values[4] && self.values[4] == self.values[6])
        ) {
            if(self.playerTurn == 1){
                self.scoreO += 1
                winnerText.text = "Player \(self.playerTurn) won the game"
            }else{
                self.scoreX += 1
                winnerText.text = "Player \(self.playerTurn) won the game"
            }
            
            scoreTxt.text = "X : \(self.scoreX) - O : \(self.scoreO)"
            let alert = UIAlertController(title: "C'est fini !", message: "Que voulez-vous faire maintenant ? ", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Retour à la page d'accueil", style: .default, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Recommencer une partie", style: .default, handler: { (_) in
                self.values = [0, 0, 0, 0, 0, 0, 0, 0, 0]
                self.playerTurn = 1
                self.winnerText.text = ""
                for i in 0 ... 9{
                    var all = self.view .viewWithTag(i) as? UIButton
                    all?.setImage(nil, for: [])
                }
                self.view.viewWithTag(2)
            }))
            self.present(alert, animated: true)

          }
        
        self.playerTurn = (self.playerTurn == 1 ? 2 : 1)
    }
}
