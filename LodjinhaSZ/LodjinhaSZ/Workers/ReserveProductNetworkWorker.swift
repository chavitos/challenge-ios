//
//  ReserveProductNetworkWorker.swift
//  LodjinhaSZ
//
//  Created by Tiago Chaves on 06/06/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class ReserveProductNetworkWorker:ProductDetailWorkerProtocol{
	
	func reserve(product productId: Int, completion: @escaping (() throws -> ProductReserve) -> Void) {
		
		let request = LodjinhaSZRequests.reserveProduct(productId: productId)
		
		NetworkManager.request(withURL: request) { (data, response, error) in
			
			if error == nil, let data = data {
				
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let reservationResult = try decoder.decode(ProductReserve.self, from: data)
					
					completion { return reservationResult }
				}catch{
					completion{ throw error }
				}
			}else{
				NSLog("Erro ao tentar reservar o produto -> \(error?.localizedDescription ?? "")")
				completion{ throw error! }
			}
		}
	}
}
