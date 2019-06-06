//
//  CornerRadiusButton.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

@IBDesignable class CornerRadiusButton: UIButton {
	
	@IBInspectable var cornerRadius:CGFloat = 0.0 {
		didSet {
			layer.cornerRadius = cornerRadius
		}
	}
}
