//
//  ProductDetailInteractor.swift
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

protocol ProductDetailBusinessLogic {
	func getProduct(request: ProductDetail.ShowProductDetail.Request)
	func reserveProduct(request: ProductDetail.ReserveProduct.Request)
}

protocol ProductDetailDataStore {
	var product:ProductViewModel? { get set }
}

class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
	
	var presenter	: ProductDetailPresentationLogic?
	var product		: ProductViewModel?
	
	var worker		: ProductDetailWorker?
	let reserveProductWorker = ReserveProductNetworkWorker()
	
	// MARK: Get Product
	
	func getProduct(request: ProductDetail.ShowProductDetail.Request) {
		
		let response = ProductDetail.ShowProductDetail.Response(product: self.product)
		presenter?.presentProductDetail(response: response)
	}
	
	// MARK: Reserve Product
	
	func reserveProduct(request: ProductDetail.ReserveProduct.Request) {
		
		worker = ProductDetailWorker(reserveProductWorker)
		worker?.reserve(product: self.product?.id ?? -1, completion: { (reserve, error) in
			
			var response:ProductDetail.ReserveProduct.Response
			
			if error == nil {
				
				response = ProductDetail.ReserveProduct.Response(productReserve: reserve, error: nil)
			}else{
				
				response = ProductDetail.ReserveProduct.Response(productReserve: nil, error: error)
			}
			
			self.presenter?.presentReserveMessage(response: response)
		})
	}
}