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

	static let BASEURL = "http://192.168.11.3:5000"
	static var alamoFireManager : SessionManager? // this line
	static var notifiedAboutLoss = false

	static func initialize(){
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 1
		configuration.timeoutIntervalForResource = 1
		alamoFireManager = Alamofire.SessionManager(configuration: configuration)
	}

    static func heartbeat() {
		ServerCommunication.alamoFireManager?.request(BASEURL,
                          method: .get)
            .validate()
            .responseString { response in
				switch response.result{
				case .success:
					print(response)
					break
				case .failure:
					NotificationHandler().pushOutOfRangeNotification()
					if !ServerCommunication.notifiedAboutLoss{
					ServerCommunication.notifiedAboutLoss = true
					let alertController = UIAlertController(title: "Bag out of range!", message:
						"Lost connection to bag.", preferredStyle: UIAlertControllerStyle.alert)
					alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: {_ in
						DispatchQueue.global().async {
							sleep(10)
							ServerCommunication.notifiedAboutLoss = true
						}
					}))
					UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
					}

					print("Lost conncetion to server")

				}
        }
    }

	static func getHallSensorValue(){
		let url = BASEURL + "/hall"
		ServerCommunication.alamoFireManager?.request(url,
						  method: .get)
			.validate()
			.responseString { response in
				print(response)
		}
	}
}
