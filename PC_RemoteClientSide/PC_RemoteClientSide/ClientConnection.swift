//
//  ClientConnection.swift
//  PC_ControllerApp
//
//  Created by Pedro Vargas on 20/12/19.
//  Copyright © 2019 Pedro Vargas. All rights reserved.
//

import Foundation
import Network

class ClientConnection {
    
    let  nwConnection: NWConnection
    let queue = DispatchQueue(label: "Client connection Q")

    init(nwConnection: NWConnection) {
        self.nwConnection = nwConnection
    }

    var didStopCallback: ((Error?) -> Void)? = nil

    func start() {
        print("connection will start")
        nwConnection.stateUpdateHandler = stateDidChange(to:)
//        setupReceive()
        nwConnection.start(queue: queue)
    }

    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .waiting(let error):
            connectionDidFail(error: error)
        case .ready:
            print("Client connection ready")
            
            
        case .failed(let error):
            connectionDidFail(error: error)
        default:
            break
        }
    }

//    private func setupReceive() {
//        nwConnection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, isComplete, error) in
//            if let data = data, !data.isEmpty {
//                let message = String(data: data, encoding: .utf8)
//                print("connection did receive, data: \(data as NSData) string: \(message ?? "-" )")
//            }
//            if isComplete {
//                self.connectionDidEnd()
//            } else if let error = error {
//                self.connectionDidFail(error: error)
//            } else {
//                self.setupReceive()
//            }
//        }
//    }

    func send(data: String) {
        var msg = data
        nwConnection.send(content: msg.data(using: .utf8) , completion: .contentProcessed( { error in
            if let error = error {
                self.connectionDidFail(error: error)
                
                return
            }
            print("enviou")
        }))
    }

    func stop() {
        print("connection will stop")
        stop(error: nil)
    }

    private func connectionDidFail(error: Error) {
        print("connection did fail, error: \(error)")
        self.stop(error: error)
    }

    private func connectionDidEnd() {
        print("connection did end")
        self.stop(error: nil)
    }

    private func stop(error: Error?) {
        self.nwConnection.stateUpdateHandler = nil
        self.nwConnection.cancel()
        if let didStopCallback = self.didStopCallback {
            self.didStopCallback = nil
            didStopCallback(error)
        }
    }
}
