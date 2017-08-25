//
//  API.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

func API(_ request: APIRouter, completionHandler: @escaping (CurrencyConversionResult?, Error?) -> Void) {
    Alamofire        
        .request(request)
        .validate()
        .responseObject { (response: DataResponse<CurrencyConversionResult>) in
            if let error = response.result.error {
                print("error from response - ", error)
                return completionHandler(nil , error)
            } else {
                guard let currencyResponse = response.result.value else { return }
                return completionHandler(currencyResponse, nil)
            }
    }
}

