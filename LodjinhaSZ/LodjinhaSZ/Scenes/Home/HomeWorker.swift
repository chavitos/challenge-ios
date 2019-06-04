//
//  HomeWorker.swift
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

class HomeWorker {
	
	var bannerWorker:BannerListWorkerProtocol?
	var categoryWorker:CategoryListWorkerProtocol?
	var mostPopProductWorker:PopProductListWorkerProtocol?
	
	init(_ bannerWorker:BannerListWorkerProtocol?,
		 _ categoryWorker:CategoryListWorkerProtocol?,
		 _ mostPopProductWorker:PopProductListWorkerProtocol?) {
		
		self.bannerWorker = bannerWorker
		self.categoryWorker = categoryWorker
		self.mostPopProductWorker = mostPopProductWorker
	}
	
	func getBanners(completion:@escaping(BannerList?,WorkerErrors?) -> Void) {
		
		if let worker = bannerWorker {
			
			worker.getBanners { (bannerList: () throws -> BannerList) in
				
				do {
					let bannerList = try bannerList()
					completion(bannerList,nil)
				}catch let error {
					completion(nil, WorkerErrors.networkProblem(error: error))
				}
			}
		}else{
			completion(nil, WorkerErrors.workerNil)
		}
	}
	
	func getCategories(completion:@escaping(CategoryList?,WorkerErrors?) -> Void) {
		
		if let worker = categoryWorker {
			
			worker.getCategories { (categoryList: () throws -> CategoryList) in
				
				do {
					let categoryList = try categoryList()
					completion(categoryList,nil)
				}catch let error {
					completion(nil, WorkerErrors.networkProblem(error: error))
				}
			}
		}else{
			completion(nil, WorkerErrors.workerNil)
		}
	}
	
	func getPopProducts(completion:@escaping(ProductList?,Error?) -> Void) {
		
		if let worker = mostPopProductWorker {
			
			worker.getPopProducts { (popProductList: () throws -> ProductList) in
				
				do{
					let popProductList = try popProductList()
					completion(popProductList,nil)
				}catch let error {
					completion(nil, WorkerErrors.networkProblem(error: error))
				}
			}
		}else{
			completion(nil,WorkerErrors.workerNil)
		}
	}
}

protocol BannerListWorkerProtocol {
	func getBanners(completion:@escaping(() throws -> BannerList) -> Void)
}

protocol CategoryListWorkerProtocol {
	func getCategories(completion:@escaping(() throws -> CategoryList) -> Void)
}

protocol PopProductListWorkerProtocol {
	func getPopProducts(completion:@escaping(() throws -> ProductList) -> Void)
}

enum WorkerErrors:Error {
	
	case workerNil
	case networkProblem(error:Error)
	
	var errorDesc:String {
		switch self {
		case .workerNil:
			return "Worker nil! Verifique o construtor da classe."
		case .networkProblem(let error):
			return "Erro ao tentar recuperar dados do servidor: \(error)"
		}
	}
}
