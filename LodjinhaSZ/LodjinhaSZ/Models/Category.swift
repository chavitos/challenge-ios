//
//  Category.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 01/06/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by Toledo's Swift Xcode Templates
//

import Foundation

struct Category: Codable, CustomStringConvertible {
	
    let id			: Int?
	let desc		: String?
	let imageUrl	: String?
	
    enum CodingKeys:String,CodingKey{
        
        case id
		case desc 		= "descricao"
		case imageUrl 	= "urlImagem"
    }
	
    var description: String {
        return "Categoria \(self.desc ?? "-")"
    }
}

struct CategoryList: DataList {
	
	typealias T = Category
	
	var data: [Category]?
}