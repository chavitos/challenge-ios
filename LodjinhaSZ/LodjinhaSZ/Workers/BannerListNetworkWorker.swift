//
//  BannerListNetworkWorker.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 02/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class BannerListNetworkWorker:BannerListWorkerProtocol {
	
	func getBanners(completion: @escaping (() throws -> BannerList) -> Void) {
		
		let request = LodjinhaSZRequests.getBanners
		
		NetworkManager().request(withURL: request) { (data,response,error) in
			
			if error == nil, let data = data {
				
				do{
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase //já 'elimina' os _
					let banners = try decoder.decode(BannerList.self, from: data)
					
					completion{ return banners }
				}catch{
					completion{ throw error }
				}
			}else{
				NSLog("Erro ao tentar recuperar os banners do servidor -> \(error?.localizedDescription ?? "")")
				completion{ throw error! }
			}
		}
	}
}
