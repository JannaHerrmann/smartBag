//
//  ServerCommunication.swift
//  SmartBag
//
//  Created by Janna Herrmann on 12.07.18.
//  Copyright © 2018 Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH. All rights reserved.
//

import Foundation
import Alamofire

class ServerCommunication{
    
    static func fetchAllRooms() {
        let url = URL(string: "http://192.168.11.3:5000")
        Alamofire.request(url!,
                          method: .get)
            .validate()
            .responseString { response in
                print(response.result)
        }
    }
}
