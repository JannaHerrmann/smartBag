//
//  ViewController.swift
//  SmartBag
//
//  Created by Nicklas Linz on 26.06.18.
//  Copyright © 2018 Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theftButton: UIButton!
    @IBOutlet var topView: UIView!
    @IBOutlet weak var lostButton: UIButton!
    
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

		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

