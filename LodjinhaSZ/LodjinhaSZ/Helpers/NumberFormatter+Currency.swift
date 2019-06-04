//
//  NumberFormatter+Currency.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 03/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

extension NumberFormatter {
	
	func getCurrencyFormatter() -> NumberFormatter {
		
		self.numberStyle = .currencyAccounting
		self.locale = Locale(identifier: "pt_BR")
		self.maximumFractionDigits = 2
		self.minimumFractionDigits = 2
		
		return self
	}
}
