//
//  CustomTabBar.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 03/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {

	var tabItam = UITabBarItem()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let selectedColor = UIColor(red: 94/255, green: 42/255, blue: 132/255, alpha: 1.0)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selectedColor], for: .selected)

		let selectedImageHome = UIImage(named: "homeActive")?.withRenderingMode(.alwaysOriginal)
		let deselectedImageHome = UIImage(named: "homeDeselected")?.withRenderingMode(.alwaysOriginal)
		tabBarItem = self.tabBar.items![0]
		tabBarItem.image = deselectedImageHome
		tabBarItem.selectedImage = selectedImageHome
		
		let selectedImageTag = UIImage(named: "tagSelected")?.withRenderingMode(.alwaysOriginal)
		let deselectedImageTag = UIImage(named: "tagDeselected")?.withRenderingMode(.alwaysOriginal)
		tabBarItem = self.tabBar.items![1]
		tabBarItem.image = deselectedImageTag
		tabBarItem.selectedImage = selectedImageTag
		
		self.selectedIndex = 0
	}
}
