//
//  BannerScrollView.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 04/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class BannerScrollView: UIScrollView {
	
	var bannerFrame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
	
	func configBanners(_ banners:[BannerViewModel]) {
		
		for index in 0..<banners.count {
			
			bannerFrame.origin.x = self.frame.size.width * CGFloat(index)
			bannerFrame.size = self.frame.size
			
			let banner = BannerView(frame: bannerFrame)
			banner.configBannerView(withBanner: banners[index])
			
			DispatchQueue.main.async {
				self.addSubview(banner)
			}
		}
		
		DispatchQueue.main.async {
			self.contentSize = CGSize(width: self.frame.size.width * CGFloat(banners.count), height: self.frame.size.height)
		}
	}
}
