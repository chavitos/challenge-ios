//
//  EmptyLabel.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 05/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class EmptyLabel: UILabel {

	convenience init(forView view:UIView, andMessage message:String?) {
		
		let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: view.frame.size)
		
		self.init(frame: frame)
		
		self.text          		= message ?? ""
		self.textColor     		= UIColor.black
		self.backgroundColor 	= UIColor.background
		self.textAlignment 		= .center
		self.numberOfLines 		= 2
	}
}
