//
//  ProductReserve.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 02/06/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by Toledo's Swift Xcode Templates
//

import Foundation

struct ProductReserve: Codable {
	
    let result	: String?
	let message	: String?
	
    enum CodingKeys:String,CodingKey{
        
        case result
		case message = "mensagem"
    }
}
