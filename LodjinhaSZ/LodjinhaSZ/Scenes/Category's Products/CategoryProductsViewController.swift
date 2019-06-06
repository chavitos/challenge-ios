//
//  CategoryProductsViewController.swift
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

protocol CategoryProductsDisplayLogic: class {
	func displayProducts(viewModel: CategoryProducts.GetCategoryProducts.ViewModel)
	func displayCategoryName(viewModel: CategoryProducts.GetCategoryName.ViewModel)
	func displayProductDetail(viewModel: CategoryProducts.ShowProductDetail.ViewModel)
}

class CategoryProductsViewController: UIViewController, CategoryProductsDisplayLogic {
	
	var interactor: CategoryProductsBusinessLogic?
	var router: (NSObjectProtocol & CategoryProductsRoutingLogic & CategoryProductsDataPassing)?
	
	// MARK: Object lifecycle
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		setup()
	}
	
	// MARK: Setup
	
	private func setup() {
		
		let viewController = self
		let interactor = CategoryProductsInteractor()
		let presenter = CategoryProductsPresenter()
		let router = CategoryProductsRouter()
		
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	// MARK: Routing
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let scene = segue.identifier {
			
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		getCategoryName()
		getCategoryProducts()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		self.tabBarController?.tabBar.isHidden = true
	}
	
	// MARK: Get CategoryName
	
	func getCategoryName() {
		
		let request = CategoryProducts.GetCategoryName.Request()
		interactor?.getCategoryName(request: request)
	}
	
	func displayCategoryName(viewModel: CategoryProducts.GetCategoryName.ViewModel) {
		
		self.title = viewModel.categoryName ?? "Produtos"
	}
	
	// MARK: Get Category's Products
	
	@IBOutlet weak var productsTableView: UITableView!
	@IBOutlet weak var getCategoryProductsActivityIndicator: UIActivityIndicatorView!
	
	var offset	: Int = 0
	var total	: Int = 0
	let limit	: Int = 20
	
	let productCellIdentifier = "productCell"
	var products:[ProductViewModel] = []
	
	func getCategoryProducts() {
		
		getCategoryProductsActivityIndicator.startAnimating()
		let request = CategoryProducts.GetCategoryProducts.Request(offset: self.offset, limit: self.limit)
		interactor?.getCategoryProducts(request: request)
	}
	
	func displayProducts(viewModel: CategoryProducts.GetCategoryProducts.ViewModel) {
		
		getCategoryProductsActivityIndicator.stopAnimating()
		
		if viewModel.error == nil {
			
			if let products = viewModel.products, let offset = viewModel.offset, let total = viewModel.total {
			
				self.offset = offset + self.limit
				self.products += products
				self.total = total
				
				if self.products.count == 0 {
					
					let emptyLabel = EmptyLabel(forView: productsTableView, andMessage: "Não existem produtos para essa categoria")
				
					DispatchQueue.main.async {
						self.productsTableView.backgroundView  = emptyLabel
						self.productsTableView.separatorStyle  = .none
					}
				}else{
					
					DispatchQueue.main.async {
						self.productsTableView.reloadData()
					}
				}
			}
		}else{
			
			let emptyLabel = EmptyLabel(forView: productsTableView, andMessage: "Não foi possível recuperar os produtos da categoria T_T")
			
			DispatchQueue.main.async {
				self.productsTableView.backgroundView  = emptyLabel
				self.productsTableView.separatorStyle  = .none
			}
		}
	}
	
	// MARK: Show Product Detail
	
	func displayProductDetail(viewModel: CategoryProducts.ShowProductDetail.ViewModel) {
		
		self.performSegue(withIdentifier: "CategoryProductDetail", sender: nil)
	}
}

extension CategoryProductsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return products.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let product = products[indexPath.row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier, for: indexPath) as? ProductTableViewCell {
			
			cell.configCell(withProduct: product)
			
			return cell
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let cell = tableView.cellForRow(at: indexPath)
		cell?.isSelected = false
		
		let product = self.products[indexPath.row]
		
		interactor?.storeProduct(request: CategoryProducts.ShowProductDetail.Request(product: product))
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		if indexPath.row == products.count - 1 {
			
			if offset < total {
				
				getCategoryProducts()
			}
		}
	}
}
