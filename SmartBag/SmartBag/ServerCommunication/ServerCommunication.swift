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

	static let BASEURL = "http://192.168.11.2:5000"
	static var alamoFireManager : SessionManager? // this line
	static var notifiedAboutLoss = false
    static var notifiedAboutOpen = false
    static var connected = false

	static func initialize(){
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 1
		configuration.timeoutIntervalForResource = 1
		alamoFireManager = Alamofire.SessionManager(configuration: configuration)
	}

    static func heartbeat() {
        let url = BASEURL + "/hall"
		ServerCommunication.alamoFireManager?.request(url,
                          method: .get)
            .validate()
            .responseString { response in
				switch response.result{
				case .success:
                    print(Int(response.result.value!)!)
                    if(Int(response.result.value!)! == 1){
                        if (!ServerCommunication.notifiedAboutOpen && ViewController.alerrtTheftOpen){
                            
                            ServerCommunication.notifiedAboutOpen = true
                            let alertController = UIAlertController(title: "Bag was opened!", message:
                                "Lost connection to bag.", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: {_ in
                                DispatchQueue.global().async {
                                    sleep(10)
                                    ServerCommunication.notifiedAboutOpen = true
                                }
                            }))
                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                            NotificationHandler.pushOpeningNotification()
                        }
                    }
                    else if (Int(response.result.value!)! == 0){
                        ServerCommunication.notifiedAboutOpen = false
                    }
                    self.connected = true
					break
				case .failure:
                    self.connected = false
                    if (!ServerCommunication.notifiedAboutLoss && ViewController.alerOutOfRange){
                        NotificationHandler.pushOutOfRangeNotification()
					
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
