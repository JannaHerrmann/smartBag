//
//  ViewController.swift
//  SmartBag
//
//  Created by Nicklas Linz on 26.06.18.
//  Copyright © 2018 Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var theftButton: UIButton!
    @IBOutlet var topView: UIView!
    @IBOutlet weak var lostButton: UIButton!
    var simpleBluetoothIO: SimpleBluetoothIO!
    @IBOutlet weak var connectedLabel: UILabel!
    
    static var alerrtTheftOutOfRange = true
    static var alerrtLossOutOfRange = true
    static var alerrtTheftOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.layer.borderWidth = 1.0
        self.topView.layer.borderColor = #colorLiteral(red: 0.2056839466, green: 0.4766893387, blue: 0.4690987468, alpha: 1)
        
        self.theftButton.layer.borderWidth = 1.0
        self.theftButton.layer.borderColor = #colorLiteral(red: 0.2056839466, green: 0.4766893387, blue: 0.4690987468, alpha: 1)
        self.theftButton.layer.cornerRadius = 10
        self.theftButton.layer.borderWidth = 1

        self.lostButton.layer.borderWidth = 1.0
        self.lostButton.layer.borderColor = #colorLiteral(red: 0.2056839466, green: 0.4766893387, blue: 0.4690987468, alpha: 1)
        self.lostButton.layer.cornerRadius = 10
        self.lostButton.layer.borderWidth = 1
        
        NotificationHandler().pushOpeningNotification()
        
        DispatchQueue.global().async {
            while(true){
                ServerCommunication.heartbeat()
                
                if (ServerCommunication.connected){
                    DispatchQueue.main.async {
                        self.setConnected(connected: true)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.setConnected(connected: false)
                    }
                }
                
                sleep(1)
            }
        }
    }
    
    func setConnected(connected: Bool){
        if (connected){
            self.connectedLabel.text = "Connected"
            self.connectedLabel.textColor = #colorLiteral(red: 0.2056839466, green: 0.4766893387, blue: 0.4690987468, alpha: 1)
            
        }
        else{
            self.connectedLabel.text = "Not connected"
            self.connectedLabel.textColor = UIColor.red
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ViewController: SimpleBluetoothIODelegate {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
        if value > 0 {
            print("Receive greater 0")
        } else {
            print("Receive else")
        }
    }
}

