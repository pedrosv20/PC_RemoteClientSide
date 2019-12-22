//
//  ModelClient.swift
//  PC_RemoteClientSide
//
//  Created by Pedro Vargas on 22/12/19.
//  Copyright © 2019 Pedro Vargas. All rights reserved.
//

import Foundation
class ModelClient {
    
    static let shared = ModelClient()
    
    var ip_adress: String?
    
    private init() {}
    
}
