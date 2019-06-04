//
//  CategoryCollectionViewCell.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 04/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var categoryImageView: UIImageView!
	@IBOutlet weak var categoryDescLabel: UILabel!
	
	override func prepareForReuse() {
		
		categoryImageView.image = nil
		categoryDescLabel.text = ""
	}
	
	func configCell(withCategory category:CategoryViewModel) {
		
		if let url = category.categoryImageUrl {
			categoryImageView.setImage(withUrl: url)
		}else{
			categoryImageView.image = nil
		}
		
		categoryDescLabel.text = category.desc ?? "-"
	}
}
