//
//  AppInfoView.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit
import Cartography

class AppInfoView: UIView {

	let logoImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "logoSobre")
		
		return imageView
	}()
	
	let appNameLabel:UILabel = {
		
		let label = UILabel()
		label.font = UIFont.niceFont
		label.textColor = UIColor.darkColor
		label.text = "a Lodjinha"
		
		return label
	}()
	
	let devNameLabel:UILabel = {
		
		let label = UILabel()
		label.font = UIFont.devTagFont
		label.textColor = UIColor.darkColor
		label.text = "Tiago Toledo da Costa Chaves"
		
		return label
	}()
	
	let dateLabel:UILabel = {
		
		let label = UILabel()
		label.font = UIFont.dateTagFont
		label.textColor = UIColor.darkColor
		label.text = "07 de junho de 2019"
		
		return label
	}()

	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension AppInfoView: CodeView {
	
	func setupComponents() {
		
		addSubview(logoImageView)
		addSubview(appNameLabel)
		addSubview(devNameLabel)
		addSubview(dateLabel)
	}
	
	func setupConstraints() {
		
		constrain(logoImageView, self) {
			
			$0.centerX == $1.centerX
			$0.centerY == $1.centerY - 60
			$0.height == 150.0
			$0.width == 150.0
		}
		
		constrain(appNameLabel, logoImageView) {
			
			$0.top == $1.bottomMargin + 14.0
			$0.centerX == $1.centerX
		}
		
		constrain(dateLabel, self) {
			
			$0.bottom == $1.bottomMargin - 12.0
			$0.centerX == $1.centerX
		}
		
		constrain(devNameLabel, dateLabel) {
			
			$0.bottom == $1.topMargin - 16.0
			$0.centerX == $1.centerX
		}
	}
	
	func setupExtraConfiguration() {
		
		backgroundColor = .background
	}
}
