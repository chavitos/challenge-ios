//
//  ProductTableViewCell.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 04/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
	
	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var productNameLabel: UILabel!
	
	@IBOutlet weak var originalPriceLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var view: UIView!
	
	override func prepareForReuse() {
		
		productImageView.image = UIImage()
		productNameLabel.text = ""
		originalPriceLabel.text = ""
		priceLabel.text = ""
		
		originalPriceLabel.isHidden = false
		view.isHidden = false
	}
	
	func configCell(withProduct product:ProductViewModel) {
		
		if let url = product.imageUrl {
			productImageView.setImage(withUrl: url)
		}else{
			productImageView.image = UIImage()
		}
		
		productNameLabel.attributedText = "\(product.name ?? "Produto:") \(product.desc ?? "-")".htmlToAttributedString
		
		if product.isPromotion {
			originalPriceLabel.isHidden = false
			view.isHidden = false
			originalPriceLabel.text = "\(product.originalPrice ?? "R$ --")"
			priceLabel.text = "\(product.price ?? "R$ --")"
		}else{
			originalPriceLabel.isHidden = true
			view.isHidden = true
			priceLabel.text = "\(product.price ?? "R$ --")"
		}
	}
}
