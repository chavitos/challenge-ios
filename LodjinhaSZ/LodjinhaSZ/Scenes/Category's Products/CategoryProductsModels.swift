//
//  CategoryProductsModels.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 05/06/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CategoryProducts {
	
	// MARK: Use cases
	
	enum GetCategoryName {
		
		struct Request {
			
		}
		
		struct Response {
			
			var categoryName:String?
		}
		
		struct ViewModel {
			
			var categoryName:String?
		}
	}
	
	enum GetCategoryProducts {
		
		struct Request {
			
			var offset	: Int
			var limit	: Int
		}
		
		struct Response {
			
			var products: ProductList?
			var error	: Error?
		}
		
		struct ViewModel {
			
			var products: [ProductViewModel]?
			var offset	: Int?
			var total	: Int?
			var error	: Error?
		}
	}
	
	enum ShowProductDetail {
		
		struct Request {
			
			var product: ProductViewModel?
		}
		
		struct Response {
			
			
		}
		
		struct ViewModel {
			
			
		}
	}
}
