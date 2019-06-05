//
//  HomeModels.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 02/06/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Home {
	
	enum GetBannerList {
		
		struct Request {
			
		}
		
		struct Response {
			
			var banners:BannerList?
			var error:Error?
		}
		
		struct ViewModel {
			
			var banners:[BannerViewModel]?
			var error:Error?
		}
	}
	
	enum GetCategoryList {
		
		struct Request {
			
			
		}
		struct Response {
			
			var categories:CategoryList?
			var error:Error?
		}
		struct ViewModel {
			
			var categories:[CategoryViewModel]?
			var error:Error?
		}
	}
	
	enum GetPopProductList {
		
		struct Request {
			
			
		}
		struct Response {
			
			var popProducts:ProductList?
			var error:Error?
		}
		struct ViewModel {
			
			var popProducts:[ProductViewModel]?
			var error:Error?
		}
	}
	
	enum ShowNextScreen {
		
		struct Request {
			
			var nextScreen:NextScreen
		}
		
		struct Response {
			
			var nextScreen:NextScreen
		}
		
		struct ViewModel {
			
			var nextScreen:NextScreen
		}
	}
}

struct BannerViewModel {
	
	let bannerImageUrl	:String?
	let bannerLink		:String?
}

struct CategoryViewModel {
	
	let id					: Int?
	let desc				: String?
	let categoryImageUrl	: String?
}

struct ProductViewModel {
	
	let category		: CategoryViewModel?
	let desc			: String?
	let id				: Int?
	let name			: String?
	let originalPrice	: String?
	let price			: String?
	let imageUrl		: String?
	let isPromotion		: Bool
}
