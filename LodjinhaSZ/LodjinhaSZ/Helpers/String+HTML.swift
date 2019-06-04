//
//  String+HTML.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 04/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

extension String {
	
	var htmlToAttributedString: NSAttributedString? {
		
		guard let data = data(using: .utf8) else {
			return NSAttributedString()
		}
		
		do {
			return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch {
			return NSAttributedString()
		}
	}
}
