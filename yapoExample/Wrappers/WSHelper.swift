//
//  WSHelper.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation;
import Alamofire;

class WSHelper{    
    static func wsRequestWithCallback(url: String, _self: NetworkingRequest, method: HTTPMethod, parameters: Parameters?, completion: @escaping (DataResponse<Any>)->()) {
        Alamofire.request(url, method: method, parameters: parameters)
            .responseJSON(completionHandler: { response in
                completion(response)
            });
    }
}
