//
//  CustomViewController.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

protocol CustomViewController {
	
	associatedtype CustomView: UIView
}

extension CustomViewController where Self: UIViewController {
	
	var customView: CustomView {
		
		guard let customView = view as? CustomView else {
			fatalError("View deveria ser \(CustomView.self) mas foi \(type(of: view))")
		}
		
		return customView
	}
}
