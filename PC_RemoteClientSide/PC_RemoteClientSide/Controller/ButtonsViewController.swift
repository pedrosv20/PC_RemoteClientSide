//
//  ViewController.swift
//  PC_ControllerApp
//
//  Created by Pedro Vargas on 19/12/19.
//  Copyright © 2019 Pedro Vargas. All rights reserved.
//
import Network
import UIKit

class ButtonsViewController: UIViewController {
    var cliente: Client!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //"192.168.0.14"
        cliente = initClient(server: ModelClient.shared.ip_adress!, port: 2000)
        
        
        //TODO: back button resets model
        
    }
    
    func initClient(server: String, port: UInt16) -> Client{
        let client = Client(host: server, port: port)
        client.start()
        return client
        
        
    }
    
    @IBAction func action(_ sender: UIButton) {
        cliente.send(data: (sender.titleLabel!.text!))
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false) {
            ModelClient.shared.ip_adress = nil
        }
    }
    
}

