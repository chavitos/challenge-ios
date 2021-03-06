//
//  ProductDetailModels.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ProductDetail {
	
	// MARK: Use cases
	
	enum ShowProductDetail {
		
		struct Request {
			
		}
		
		struct Response {
			
			var product:ProductViewModel?
		}
		
		struct ViewModel {
			
			var product:ProductViewModel?
		}
	}
	
	enum ReserveProduct {
		
		struct Request {
			
		}
		
		struct Response {
			
			var productReserve:ProductReserve?
			var error:Error?
		}
		
		struct ViewModel {
			
			var message:String
			var error:Error?
		}
	}
}
