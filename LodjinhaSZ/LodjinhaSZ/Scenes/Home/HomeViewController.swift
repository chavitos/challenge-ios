//
//  HomeViewController.swift
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

protocol HomeDisplayLogic: class {
	func displayBanners(viewModel: Home.GetBannerList.ViewModel)
	func displayCategories(viewModel: Home.GetCategoryList.ViewModel)
	func displayPopProducts(viewModel: Home.GetPopProductList.ViewModel)
	func displayNextScreen(viewModel: Home.ShowNextScreen.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
	
	var interactor: HomeBusinessLogic?
	var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
	
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
		let interactor = HomeInteractor()
		let presenter = HomePresenter()
		let router = HomeRouter()
		
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
		
		let navImage = UIImage(named: "logoNavbar")
		let navImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 115.0, height: 30.0))
		navImageView.contentMode = .scaleAspectFill
		navImageView.clipsToBounds = true
		navImageView.image = navImage
		self.navigationItem.titleView = navImageView
		
		getBanners()
		getCategories()
		getPopProducts()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		self.tabBarController?.tabBar.isHidden = false
	}
	
	// MARK: GetBanners
	
	@IBOutlet weak var bannerPageControl: UIPageControl!
	@IBOutlet weak var bannerScrollView: BannerScrollView!
	@IBOutlet weak var getBannersActivityIndicator: UIActivityIndicatorView!
	
	func getBanners() {
		
		getBannersActivityIndicator.startAnimating()
		
		let request = Home.GetBannerList.Request()
		interactor?.getBanners(request: request)
	}
	
	func displayBanners(viewModel: Home.GetBannerList.ViewModel) {
		
		getBannersActivityIndicator.stopAnimating()
		
		if viewModel.error == nil, let banners = viewModel.banners {
		
			bannerPageControl.numberOfPages = banners.count
			bannerScrollView.configBanners(banners)
		}else{

			let emptyLabel = EmptyLabel(forView: bannerScrollView, andMessage: "Não foi possível recuperar os banners x_X")
			
			DispatchQueue.main.async {
				self.bannerScrollView.addSubview(emptyLabel)
			}
		}
	}
	
	// MARK: Get Categories
	
	@IBOutlet weak var categoryCollection: UICollectionView!
	@IBOutlet weak var getCategoriesActivityIndicator: UIActivityIndicatorView!
	
	let categoryCellIdentifier = "categoryCell"
	var categories:[CategoryViewModel] = []
	
	func getCategories() {
		
		getCategoriesActivityIndicator.startAnimating()
		
		let request = Home.GetCategoryList.Request()
		interactor?.getCategories(request: request)
	}
	
	func displayCategories(viewModel: Home.GetCategoryList.ViewModel) {
		
		getCategoriesActivityIndicator.stopAnimating()
		
		if viewModel.error == nil, let categories = viewModel.categories {
			self.categories = categories
			
			DispatchQueue.main.async {
				self.categoryCollection.reloadData()
			}
		}else{
			
			let emptyLabel = EmptyLabel(forView: categoryCollection, andMessage: "Não foi possível recuperar as categorias :'(")
			
			DispatchQueue.main.async {
				self.categoryCollection.backgroundView  = emptyLabel
			}
		}
	}
	
	// MARK: Get Pop Products
	
	@IBOutlet weak var productTableView: UITableView!
	@IBOutlet weak var getPopProductsActivityIndicator: UIActivityIndicatorView!
	
	let productCellIdentifier = "productCell"
	var popProducts:[ProductViewModel] = []
	
	func getPopProducts() {
		
		getPopProductsActivityIndicator.startAnimating()
		
		let request = Home.GetPopProductList.Request()
		interactor?.getPopProducts(request: request)
	}
	
	func displayPopProducts(viewModel: Home.GetPopProductList.ViewModel) {
		
		getPopProductsActivityIndicator.stopAnimating()
		
		if viewModel.error == nil, let popProducts = viewModel.popProducts {
			self.popProducts = popProducts
			
			DispatchQueue.main.async {
				self.productTableView.reloadData()
			}
		}else{
			
			let emptyLabel = EmptyLabel(forView: productTableView, andMessage: "Não foi possível recuperar os produtos mais vendidos :'(")
			
			DispatchQueue.main.async {
				self.productTableView.backgroundView  = emptyLabel
				self.productTableView.separatorStyle  = .none
			}
		}
	}
	
	func displayNextScreen(viewModel: Home.ShowNextScreen.ViewModel) {
		
		switch viewModel.nextScreen {
		case .categoryProducts:
			self.performSegue(withIdentifier: "CategoryProducts", sender: nil)
		case .productDetail:
			self.performSegue(withIdentifier: "ProductDetail", sender: nil)
		}
	}
}

extension HomeViewController:UIScrollViewDelegate {
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		
		let page = scrollView.contentOffset.x / scrollView.frame.size.width
		bannerPageControl.currentPage = Int(page)
	}
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return popProducts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let product = popProducts[indexPath.row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier, for: indexPath) as? ProductTableViewCell {
			
			cell.configCell(withProduct: product)
			
			return cell
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let cell = tableView.cellForRow(at: indexPath)
		cell?.isSelected = false
		
		let product = self.popProducts[indexPath.row]
		
		let request = Home.ShowNextScreen.Request(nextScreen: .productDetail(product: product))
		self.interactor?.storeDataToNextScreen(request: request)
	}
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return categories.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let height = collectionView.frame.size.height - 16
		let width = (height / 20.0) * 17
		
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let category = categories[indexPath.row]
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as? CategoryCollectionViewCell {
			
			cell.configCell(withCategory: category)
			
			return cell
		}
		
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let category = self.categories[indexPath.row]
		
		let request = Home.ShowNextScreen.Request(nextScreen: .categoryProducts(category: category))
		self.interactor?.storeDataToNextScreen(request: request)
	}
}
