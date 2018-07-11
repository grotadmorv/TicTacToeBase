//
//  OnLoadController.swift
//  tictactoe
//
//  Created by SUP'Internet 10 on 27/06/2018.
//  Copyright © 2018 SUP'Internet 02. All rights reserved.
//

import UIKit

class OnLoadController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var loaderText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playButton.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 30)
        TTSocket.sharedInstance.socket.on("join_game", callback: { (data, ack) in
            self.performSegue(withIdentifier: "seguePlayOnline", sender: data)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "seguePlayOnline"){
            let controller = segue.destination as! OnlineController
            controller.data = sender
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func btnLoad(_ sender: UIButton) {
        self.loaderText.font = UIFont(name: "MarkerFelt-Wide", size: 30)
        self.loaderText.text = "Waiting player ... "
        TTSocket.sharedInstance.socket.emit("join_queue", "grota")
    }

}
