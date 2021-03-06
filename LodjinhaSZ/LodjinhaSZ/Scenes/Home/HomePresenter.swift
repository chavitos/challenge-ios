//
//  HomePresenter.swift
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

enum NextScreen {
	
	case productDetail(product:ProductViewModel)
	case categoryProducts(category:CategoryViewModel)
}

protocol HomePresentationLogic {
	func presentBanners(response: Home.GetBannerList.Response)
	func presentCategories(response: Home.GetCategoryList.Response)
	func presentPopProducts(response: Home.GetPopProductList.Response)
	func presentNextScreen(response: Home.ShowNextScreen.Response)
}

class HomePresenter: HomePresentationLogic {
	
	weak var viewController: HomeDisplayLogic?
	
	// MARK: Get Banners
	
	func presentBanners(response: Home.GetBannerList.Response) {
		
		var viewModel:Home.GetBannerList.ViewModel
		
		if response.error == nil, let banners = response.banners {
			
			let bannersViewModel = getViewModel(ofBanners: banners)
			viewModel = Home.GetBannerList.ViewModel(banners: bannersViewModel, error: nil)
		}else{
			
			viewModel = Home.GetBannerList.ViewModel(banners: nil, error: response.error)
		}
		
		self.viewController?.displayBanners(viewModel: viewModel)
	}
	
	private func getViewModel(ofBanners banners:BannerList) -> [BannerViewModel] {
		
		var viewModelBanners:[BannerViewModel] = []
		
		for banner in banners.data ?? [] {
			
			let viewModelBanner = BannerViewModel(bannerImageUrl: banner.imageUrl,
												  bannerLink: banner.urlLink)
			viewModelBanners.append(viewModelBanner)
		}
		
		return viewModelBanners
	}
	
	// MARK: Get Categories
	
	func presentCategories(response: Home.GetCategoryList.Response) {
		
		var viewModel:Home.GetCategoryList.ViewModel
		
		if response.error == nil, let categories = response.categories {
			
			let categoriesViewModel = getViewModel(ofCategories: categories)
			viewModel = Home.GetCategoryList.ViewModel(categories: categoriesViewModel, error: nil)
		}else{
			
			viewModel = Home.GetCategoryList.ViewModel(categories: nil, error: response.error)
		}
		
		viewController?.displayCategories(viewModel: viewModel)
	}
	
	private func getViewModel(ofCategories categories:CategoryList) -> [CategoryViewModel] {
		
		var viewModelCategories:[CategoryViewModel] = []
		
		DispatchQueue.global(qos: .utility).sync {
			
			for category in categories.data ?? [] {
				
				let viewModelCategory = CategoryViewModel(id: category.id,
														  desc: category.desc,
														  categoryImageUrl: category.imageUrl)
				viewModelCategories.append(viewModelCategory)
			}
		}
		
		return viewModelCategories
	}
	
	// MARK: Get Pop Products
	
	func presentPopProducts(response: Home.GetPopProductList.Response) {
		
		var viewModel:Home.GetPopProductList.ViewModel
		
		if response.error == nil, let popProducts = response.popProducts {
			
			let popProductsViewModel = getViewModel(ofPopProducts: popProducts)
			viewModel = Home.GetPopProductList.ViewModel(popProducts: popProductsViewModel, error: nil)
		}else{
			
			viewModel = Home.GetPopProductList.ViewModel(popProducts: nil, error: response.error)
		}
		
		viewController?.displayPopProducts(viewModel: viewModel)
	}
	
	private func getViewModel(ofPopProducts popProducts:ProductList) -> [ProductViewModel] {
		
		var viewModelPopProducts:[ProductViewModel] = []
		
		DispatchQueue.global(qos: .utility).sync {
			
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
		}
		
		return viewModelPopProducts
	}
	
	// MARK: Present Next Screen (see enum NextScreen to knwo the options)
	
	func presentNextScreen(response: Home.ShowNextScreen.Response) {
		
		viewController?.displayNextScreen(viewModel: Home.ShowNextScreen.ViewModel(nextScreen: response.nextScreen))
	}
}
