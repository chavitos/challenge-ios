//
//  DownloadHelper.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 02/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation
import UIKit

class DownloadHelper {
	
	static let sharedInstance = DownloadHelper()
	private init() {}
	
	private let cache = NSCache<AnyObject, AnyObject>()
	
	func cachedImageRequest(fromUrl url: String, completion:@escaping(UIImage?,Error?) -> Void){
		
		guard let url = URL(string: url) else{
			completion(nil,CachedRequestErrors.invalidUrl)
			return
		}
		
		if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage {
			
			print("Cached return!")
			completion(imageFromCache,nil)
		}else{
		
			URLSession.shared.dataTask(with: url) { data, response, error in
				
				if error == nil, let data = data {
					
					if let imageToCache = UIImage(data: data) {
						
						self.cache.setObject(imageToCache as AnyObject, forKey: url as AnyObject)
						
						print("Request return!")
						completion(imageToCache,nil)
					}else{
						completion(nil,error)
					}
				}
			}.resume()
		}
	}
}

enum CachedRequestErrors:Error {
	
	case invalidUrl
	case cacheRequestError(error:Error)
	
	var errorDesc:String {
		
		switch self {
		case .invalidUrl:
			return "Url inválida."
		case .cacheRequestError(let error):
			return "Erro ao tentar recuperar/buscar dados da cache: \(error)"
		}
	}
}
