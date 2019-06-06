//
//  CategoryProductsInteractor.swift
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

protocol CategoryProductsBusinessLogic {
	func getCategoryProducts(request: CategoryProducts.GetCategoryProducts.Request)
	func getCategoryName(request: CategoryProducts.GetCategoryName.Request)
	func storeProduct(request: CategoryProducts.ShowProductDetail.Request)
}

protocol CategoryProductsDataStore {
	var category	: CategoryViewModel? 	{ get set }
	var product		: ProductViewModel? 	{ get set }
}

class CategoryProductsInteractor: CategoryProductsBusinessLogic, CategoryProductsDataStore {
	
	var presenter	: CategoryProductsPresentationLogic?
	var worker		: CategoryProductsWorker?
	var categoryProductsWorker: CategoryProductsWorkerProtocol = CategoryProductsNetworkWorker()
	
	var category	: CategoryViewModel?
	var product		: ProductViewModel?
	
	// MARK: Get Category Name
	
	func getCategoryName(request: CategoryProducts.GetCategoryName.Request) {
		
		let response = CategoryProducts.GetCategoryName.Response(categoryName: category?.desc)
		presenter?.presentCategoryName(response: response)
	}
	
	// MARK: Get Category's Products
	
	func getCategoryProducts(request: CategoryProducts.GetCategoryProducts.Request) {
		
		worker = CategoryProductsWorker(categoryProductsWorker)
		worker?.getProducts(ofCategory: self.category?.id ?? -1, withOffset: request.offset, andLimit: request.limit, completion: { (productList, error) in
			
			let response:CategoryProducts.GetCategoryProducts.Response
			
			if error == nil {
				response = CategoryProducts.GetCategoryProducts.Response(products: productList, error: nil)
			}else{
				response = CategoryProducts.GetCategoryProducts.Response(products: nil, error: error)
			}
			
			self.presenter?.presentCategoryProducts(response: response)
		})
	}
	
	// MARK: Store Product
	
	func storeProduct(request: CategoryProducts.ShowProductDetail.Request) {
		
		presenter?.presentProductDetail(response: CategoryProducts.ShowProductDetail.Response())
	}
}
