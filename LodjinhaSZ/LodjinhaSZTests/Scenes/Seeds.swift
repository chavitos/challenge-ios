//
//  Seeds.swift
//  LodjinhaSZTests
//
//  Created by Tiago Chaves on 07/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

@testable import LodjinhaSZ
import Foundation

struct Seeds {
	
	struct ViewModels {
		
		static let category = CategoryViewModel(id: 9,
												desc: "categoria9",
												categoryImageUrl: "imageUrl9")
		
		static let product = ProductViewModel(category: category,
											  desc: "network product10",
											  id: 10,
											  name: "product10",
											  originalPrice: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 100)),
											  price: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 100)),
											  imageUrl: "url10",
											  isPromotion: true)
		
		static let product1 = ProductViewModel(category: category,
											  desc: "network product10",
											  id: 10,
											  name: "product10",
											  originalPrice: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 100)),
											  price: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 50)),
											  imageUrl: "url10",
											  isPromotion: true)
		
		static let product2 = ProductViewModel(category: category,
											   desc: "network product11",
											   id: 11,
											   name: "product11",
											   originalPrice: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 200)),
											   price: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 100)),
											   imageUrl: "url11",
											   isPromotion: true)
		
		static let product3 = ProductViewModel(category: category,
											   desc: "network product12",
											   id: 12,
											   name: "product12",
											   originalPrice: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 300)),
											   price: NumberFormatter().getCurrencyFormatter().string(from: NSNumber(value: 150)),
											   imageUrl: "url12",
											   isPromotion: true)
		
		static let productsViewModel = CategoryProducts.GetCategoryProducts.ViewModel(products: [product1,
																								 product2,
																								 product3],
																					  offset: 3,
																					  total: 3,
																					  error: nil)
	}
	
	struct NetworkModels {
		
		static let netoworkCategory = Category(id: 9, desc: "categoria9", imageUrl: "imageUrl9")
		
		static let networkProduct1 = Product(category: netoworkCategory,
											 desc: "network product10",
											 id: 10,
											 name: "product10",
											 originalPrice: 100,
											 price: 50,
											 imageUrl: "url10")
		
		static let networkProduct2 = Product(category: netoworkCategory,
											 desc: "network product11",
											 id: 11,
											 name: "product11",
											 originalPrice: 200,
											 price: 100,
											 imageUrl: "url11")
		
		static let networkProduct3 = Product(category: netoworkCategory,
											 desc: "network product12",
											 id: 12,
											 name: "product12",
											 originalPrice: 300,
											 price: 150,
											 imageUrl: "url12")
		
		static let networkProductList = ProductList(data: [networkProduct1,
														   networkProduct2,
														   networkProduct3],
													offset: 0,
													total: 3)
	}
}
