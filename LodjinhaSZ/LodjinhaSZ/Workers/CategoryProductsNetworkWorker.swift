//
//  CategoryProductsNetworkWorker.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 05/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class CategoryProductsNetworkWorker:CategoryProductsWorkerProtocol{
	
	
	func getProducts(ofCategory categoryId: Int, withOffset offset: Int, andLimit limit: Int, completion: @escaping (() throws -> ProductList) -> Void) {
	
		let request = LodjinhaSZRequests.getProducts(offset: offset, limit: limit, categoryId: categoryId)
		
		NetworkManager.request(withURL: request) { (data, response, error) in
			
			if error == nil, let data = data {
				
				do{
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase //já 'elimina' os _
					let products = try decoder.decode(ProductList.self, from: data)
					
					completion{ return products }
				}catch{
					completion{ throw error }
				}
			}else{
				NSLog("Erro ao tentar recuperar os produtos da categoria do servidor -> \(error?.localizedDescription ?? "")")
				completion{ throw error! }
			}
		}
	}
}
