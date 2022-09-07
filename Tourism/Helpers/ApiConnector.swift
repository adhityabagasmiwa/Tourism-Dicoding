//
//  ApiConnector.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct ApiResponse {
    var code: Int
    var message: String
    var result: JSON
}

class ApiConnector: NSObject {
    let manager: ApiManager
    
    override init() {
        let configuration = URLSessionConfiguration.af.default
        let networkLogger = NetworkLogger()
        configuration.headers = HTTPHeaders.default
        configuration.timeoutIntervalForRequest = 60*8
        manager = ApiManager.init(configuration: configuration, interceptor: ReqInterceptor(), eventMonitors: [networkLogger])
        super.init()
    }
}

class ApiManager: Session  {
    internal override func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        var overridedParameters = [String : AnyObject]()
        
        if let parameters = parameters {
            overridedParameters = parameters as [String : AnyObject]
        }
        
        return super.request("\(BASE_URL)\(convertible)", method: method, parameters: overridedParameters, encoding: encoding, interceptor: interceptor, requestModifier: requestModifier).customValidation()
    }
}

class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.tourism.networklogger")

    func requestDidFinish(_ request: Request) {
        #if DEBUG
            print("==== REQUEST LOG ====")
            print("URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
                  + "Method: " + (request.request?.httpMethod ?? "") + "\n"
                  + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
            )
            print("Authorization: " + (request.request?.headers["Authorization"] ?? ""))
            print("Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
        #endif
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        #if DEBUG
            print("==== RESPONSE LOG ====")
            print("URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
                  + "Result: " + "\(response.result)" + "\n"
                  + "Status Code: " + "\(response.response?.statusCode ?? 0)" + "\n"
                  + "Data: \(response.data?.toPrettyPrintedString ?? "")"
            )
        #endif
  }
}

class ReqInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 2
    var isRetrying = false
    var savedRequests: [DispatchWorkItem] = []
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        
        if request.retryCount < self.retryLimit {
            if let statusCode = response?.statusCode, statusCode == 401, !isRetrying {
                self.isRetrying = true
                savedRequests.append(DispatchWorkItem { completion(.retryWithDelay(self.retryDelay)) })
            } else {
                savedRequests.append(DispatchWorkItem { completion(.retryWithDelay(self.retryDelay)) })
            }
        } else {
            completion(.doNotRetry)
        }
    }
}

