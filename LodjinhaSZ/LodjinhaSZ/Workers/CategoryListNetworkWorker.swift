//
//  CategoryListNetworkWorker.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 03/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class CategoryListNetworkWorker:CategoryListWorkerProtocol {
	
	func getCategories(completion: @escaping (() throws -> CategoryList) -> Void) {
		
		let request = LodjinhaSZRequests.getCategories
		
		NetworkManager().request(withURL: request) { (data,response,error) in
			
			if error == nil, let data = data {
				
				do{
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase //já 'elimina' os _
					let categories = try decoder.decode(CategoryList.self, from: data)
					
					completion{ return categories }
				}catch{
					completion{ throw error }
				}
			}else{
				NSLog("Erro ao tentar recuperar as categorias do servidor -> \(error?.localizedDescription ?? "")")
				completion{ throw error! }
			}
		}
	}
}
