//
//  AppStyle.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

extension UIColor {
	
	static let prettyPurple = UIColor(r: 94, g: 42, b: 132)
	static let background 	= UIColor(r: 252, g: 252, b: 252)
	static let darkColor 	= UIColor(r: 74, g: 74, b: 74)
}

extension UIColor {
	
	convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
		self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
	}
}

extension UIFont {
	
	static let niceFont 	= UIFont(name: "Pacifico-Bold", size: 68.0)
	static let devTagFont	= UIFont.systemFont(ofSize: 14.0, weight: .medium)
	static let dateTagFont	= UIFont.systemFont(ofSize: 11.0, weight: .light)
}
