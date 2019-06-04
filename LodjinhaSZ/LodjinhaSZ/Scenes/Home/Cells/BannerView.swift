//
//  BannerView.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 04/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class BannerView: UIView {
	
	var link:String = ""
	
	func configBannerView(withBanner banner:BannerViewModel) {
		
		let bannerImage = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height))
		bannerImage.setImage(withUrl: banner.bannerImageUrl ?? "")
		bannerImage.contentMode = .scaleAspectFill
		bannerImage.clipsToBounds = true
		
		if let link = banner.bannerLink {
			
			self.link = link
			
			let tap = UITapGestureRecognizer(target: self, action: #selector(open(_:)))
			self.addGestureRecognizer(tap)
		}
		
		self.addSubview(bannerImage)
	}
	
	@objc
	private func open(_ tap: UISwipeGestureRecognizer) {
		
		guard let urlLink = URL(string: self.link) else {
			return
		}
		
		if UIApplication.shared.canOpenURL(urlLink) {
			UIApplication.shared.openURL(urlLink)
		}
	}
}
