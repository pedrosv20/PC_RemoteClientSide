//
//  ViewController.swift
//  PC_ControllerApp
//
//  Created by Pedro Vargas on 19/12/19.
//  Copyright © 2019 Pedro Vargas. All rights reserved.
//
import Network
import UIKit

class ViewController: UIViewController {
    var cliente: Client!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cliente = initClient(server: "192.168.0.14", port: 2000)
        
        
        
        
    }
    
    func initClient(server: String, port: UInt16) -> Client{
        let client = Client(host: server, port: port)
        client.start()
        return client
        
        
    }
    @IBAction func action(_ sender: UIButton) {
        cliente.send(data: (sender.titleLabel!.text!))
    }
    
}

