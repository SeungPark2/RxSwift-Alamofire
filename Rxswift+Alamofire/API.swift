//
//  File.swift
//  Rxswift+Alamofire
//
//  Created by 박승태 on 2021/01/20.
//

import Foundation
import Alamofire
import RxSwift

class API {
    
    static let shared = API()
    
    private init() { }
    
    func fetchData() -> Observable<[MoneyExchange]> {
        
        return Observable.create { (observer) -> Disposable in
            
            self.callData { (error, moneyExchange) in
                                
                if let err = error {
                    
                    observer.onError(err)
                }
                
                if let moneyExchange = moneyExchange {
                    
                    observer.onNext(moneyExchange)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func callData(completion: @escaping((Error?, [MoneyExchange]?) -> Void)) {
        
        let urlStr = "http://api.manana.kr/exchange/rate/KRW/JPY,USD.json"
        
        guard let url = URL(string: urlStr)
        else {
            
            return completion(NSError(domain: "에러",
                                      code: 404,
                                      userInfo: nil), nil)
        }
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseDecodable(of: [MoneyExchange].self) { response in
                
                if let err = response.error {
                    
                    return completion(err, nil)
                }
                
                if let data = response.value {
                    
                    return completion(nil, data)
                }
            }
    }
}
