//
//  CategorysProductsViewController.swift
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

protocol CategorysProductsDisplayLogic: class {
	func displayProducts(viewModel: CategorysProducts.getCategorysProducts.ViewModel)
}

class CategorysProductsViewController: UIViewController, CategorysProductsDisplayLogic {
	
	var interactor: CategorysProductsBusinessLogic?
	var router: (NSObjectProtocol & CategorysProductsRoutingLogic & CategorysProductsDataPassing)?
	
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
		let interactor = CategorysProductsInteractor()
		let presenter = CategorysProductsPresenter()
		let router = CategorysProductsRouter()
		
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
		
		getCategorysProducts()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		self.tabBarController?.tabBar.isHidden = true
	}
	
	// MARK: Get Category's Products
	
	@IBOutlet weak var productsTableView: UITableView!
	
	var offset	: Int = 0
	var limit	: Int = 20
	var total	: Int = 0
	
	let productCellIdentifier = "productCell"
	var products:[ProductViewModel] = []
	
	func getCategorysProducts() {
		
		let request = CategorysProducts.getCategorysProducts.Request(offset: 0, limit: 0)
		interactor?.getCategorysProducts(request: request)
	}
	
	func displayProducts(viewModel: CategorysProducts.getCategorysProducts.ViewModel) {
		
		if viewModel.error == nil, let products = viewModel.products {
			
			self.offset += self.limit
			
			self.products = products
			
			DispatchQueue.main.async {
				self.productsTableView.reloadData()
			}
		}else{
			
			let emptyLabel = EmptyLabel(withView: productsTableView, andMessage: "Não foi possível recuperar os produtos da categoria T_T")
			
			DispatchQueue.main.async {
				self.productsTableView.backgroundView  = emptyLabel
				self.productsTableView.separatorStyle  = .none
			}
		}
	}
}

extension CategorysProductsViewController: UITableViewDelegate, UITableViewDataSource {
	
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
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		if indexPath.row == products.count - 1 {
			
//			if nextPage > 0 {
//				getUpcomingMovies(forPage:nextPage)
//			}
		}
	}
}
