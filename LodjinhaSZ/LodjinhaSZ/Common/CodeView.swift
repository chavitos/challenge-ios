//
//  CodeView.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

protocol CodeView {
	
	func setupComponents()
	func setupConstraints()
	func setupExtraConfiguration()
	func setup()
}

extension CodeView {
	
	func setup() {
		
		setupComponents()
		setupConstraints()
		setupExtraConfiguration()
	}
}
