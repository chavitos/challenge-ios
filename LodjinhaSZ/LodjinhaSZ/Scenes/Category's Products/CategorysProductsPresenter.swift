//
//  CategorysProductsPresenter.swift
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

protocol CategorysProductsPresentationLogic {
	func presentCategorysProducts(response: CategorysProducts.getCategorysProducts.Response)
}

class CategorysProductsPresenter: CategorysProductsPresentationLogic {
	
	weak var viewController: CategorysProductsDisplayLogic?
	
	// MARK: Get Category's Products
	
	func presentCategorysProducts(response: CategorysProducts.getCategorysProducts.Response) {
		
		var viewModel:CategorysProducts.getCategorysProducts.ViewModel
		
		if response.error == nil, let products = response.products {
			
			let productsViewModel = getViewModel(ofPopProducts: products)
			viewModel = CategorysProducts.getCategorysProducts.ViewModel(products: productsViewModel,
																		 offset: response.products?.offset,
																		 total: response.products?.total,
																		 error: nil)
		}else{
			
			viewModel = CategorysProducts.getCategorysProducts.ViewModel(products: nil, offset: nil, total: nil, error: response.error)
		}
		
		viewController?.displayProducts(viewModel: viewModel)
	}
	
	private func getViewModel(ofPopProducts popProducts:ProductList) -> [ProductViewModel] {
		
		var viewModelPopProducts:[ProductViewModel] = []
		
		for product in popProducts.data ?? [] {
			
			let currencyFormatter    = NumberFormatter().getCurrencyFormatter()
			let originalPrice = currencyFormatter.string(from: NSNumber(value: product.originalPrice ?? 0.00))
			let price = currencyFormatter.string(from: NSNumber(value: product.price ?? 0.00))
			
			let viewModelProduct = ProductViewModel(category: CategoryViewModel(id: product.category?.id,
																				desc: product.category?.desc,
																				categoryImageUrl: product.category?.imageUrl),
													desc: product.desc,
													id: product.id,
													name: product.name,
													originalPrice: originalPrice,
													price: price,
													imageUrl: product.imageUrl,
													isPromotion: product.isPromotion)
			
			viewModelPopProducts.append(viewModelProduct)
		}
		
		return viewModelPopProducts
	}
}
