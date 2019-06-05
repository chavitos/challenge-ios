//
//  PopProductListNetworkWorker.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 03/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class PopProductListNetworkWorker:PopProductListWorkerProtocol {
	
	func getPopProducts(completion: @escaping (() throws -> ProductList) -> Void) {
		
		let request = LodjinhaSZRequests.getMostPopularProducts
		
		NetworkManager.request(withURL: request) { (data,response,error) in
			
			if error == nil, let data = data {
				
				do{
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase //já 'elimina' os _
					let popProducts = try decoder.decode(ProductList.self, from: data)
					
					completion{ return popProducts }
				}catch{
					completion{ throw error }
				}
			}else{
				NSLog("Erro ao tentar recuperar os produtos mais vendidos do servidor -> \(error?.localizedDescription ?? "")")
				completion{ throw error! }
			}
		}
	}
}
