//
//  AppInfoViewController.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController, CustomViewController {
	
	typealias CustomView = AppInfoView

	override func loadView() {
		
		view = AppInfoView()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
