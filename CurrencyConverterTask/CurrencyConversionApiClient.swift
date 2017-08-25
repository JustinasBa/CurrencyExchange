//
//  CurrencyConversion.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation
import BoltsSwift

import AlamofireObjectMapper
import ObjectMapper
import Alamofire
import Typhoon
 
class CurrencyConversionApiClient: NSObject {
    
    func calculate(fromAmount: Money, toCurrency: String) -> Task<CurrencyConversionResult> {
        let taskCompletionSource = TaskCompletionSource<CurrencyConversionResult>()
        
        let request = APIRouter.exhangeCurrency(fromAmount.getAmountAsString(),fromAmount.currency, toCurrency)
        
        Alamofire
            .request(request)
            .validate()
            .responseObject { (response: DataResponse<CurrencyConversionResult>) in
                self.resolveTaskCompletionSource(taskCompletionSource: taskCompletionSource , result: response)
            }
        return taskCompletionSource.task
    }
    
    private func resolveTaskCompletionSource(taskCompletionSource: TaskCompletionSource<CurrencyConversionResult>, result: DataResponse<CurrencyConversionResult>) {
        if let error = result.error {
            taskCompletionSource.set(error: error)
        } else {
            guard let result = result.value else { return }
            taskCompletionSource.set(result: result)
        }
    }
}
