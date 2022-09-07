//
//  Extension.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

private func extractErrorMessage(reason: AFError.ResponseValidationFailureReason) -> Error {
    switch reason {
    case .customValidationFailed(let error):
        return error
    default:
        return CustomError.expected(message: "There is something wrong")
    }
}

extension DataRequest {
    func rx_JSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<JSON> {
        let observable = Observable<JSON>.create { observer in
            if let method = self.request?.httpMethod, let urlString = self.request?.url {
                print("[\(method)] \(urlString)")
                if let body = self.request?.httpBody {
                    print(NSString(data: body, encoding: String.Encoding.utf8.rawValue) as Any)
                }
            }
            
            self.responseJSON(options: options) { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    observer.onNext(json)
                case .failure(let error):
                    if let afError = error as? AFError {
                        switch afError {
                        case .responseValidationFailed(let reason):
                            observer.onError(extractErrorMessage(reason: reason))
                        default:
                            print("")
                        }
                    }
                }
            }
            return Disposables.create()
        }
        return Observable.deferred { return observable }
    }
    
    public func customValidation() -> Self {
        return validate{ request, response, data in
            let success = 200...299
            guard let jsonData = data else {
                return .failure(CustomError.unexpected(message: "Terjadi Kesalahan"))
            }
            let json = JSON(jsonData)
            if success.contains(response.statusCode) {
                return .success(())
            } else {
                if json["message"].exists() {
                    return .failure(CustomError.expected(message: json["message"].string ?? ""))
                } else {
                    return .failure(CustomError.unexpected(message: "Terjadi Kesalahan"))
                }
            }
        }
    }
}

extension Observable {
    func mapJSONResponse() -> Observable<ApiResponse> {
        
        var message: String = ""
        var status: Int = 200
        var result: JSON = JSON()
        
        return map { (item) -> ApiResponse in
            guard let json = item as? JSON else {
                fatalError("NOT A JSON!")
            }
            
            result = json
            if json["code"].exists(), let code = json["code"].int, let msg = json["message"].string {
                status = code
                message = msg
            }
            
            if json["status"].exists(), let code = json["status"].int, let msg = json["msg"].string {
                status = code
                message = msg
                result = json
            }
            return ApiResponse(code: status, message: message, result: result)
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIViewController {
    func configureNavigationBar(backgoundColor: UIColor, tintColor: UIColor, leftTitle: String) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = backgoundColor
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.compactAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = tintColor
        
        let leftLabel = UILabel()
        leftLabel.textColor = UIColor.white
        leftLabel.text = leftTitle
        leftLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftLabel)
        
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}
