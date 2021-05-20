//
//  API.swift
//  OpenMarket
//
//  Created by TORI on 2021/05/18.
//

import Foundation

enum HTTPMethodType: String {
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accept = "Accept"
}

enum HTTPHeaderValue: String {
    case apllicationJson = "apllication/json"
    case multipartFormData = "multipart/form-data"
}

class HTTPMethod {
    var boundary = "Boundary-\(UUID().uuidString)"
    
//    func createBoundary() -> String {
//        let boundary = "Boundary-\(UUID().uuidString)"
//        return boundary
//    }
    
    func setHTTPHeader(url: String, method: HTTPMethodType, header: HTTPHeaderField, value: HTTPHeaderValue) -> URLRequest {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        request.setValue("\(value.rawValue); boundary=\(boundary)", forHTTPHeaderField: "\(header.rawValue)")
        
        return request
    }
    
    func get(id: Int) {
        let session = URLSession.shared
        let url = "https://camp-open-market-2.herokuapp.com/ite/\(id)"
        
        guard let requestURL = URL(string: url) else {
            return
        }
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...399).contains(response.statusCode) else {
                return
            }
            
            guard let resultData = data else {
                return
            }
            
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(ItemInfo.self, from: resultData) else {
                return
            }
            
            print(result)
        }
        
        task.resume()
    }
    
    func post(itemInfo: ItemRegistrationForm) {
        let url = "https://camp-open-market-2.herokuapp.com/item"
        let itemInfo = jsonEncode(itemInfo: itemInfo)
        let img = itemInfo["images"] as! [String]
        
        var request = setHTTPHeader(url: url, method: .POST, header: .contentType, value: .multipartFormData)
        let body = addToHTTPBody(params: itemInfo, imageData: img[0].data(using: .utf8)!)
        
        request.httpBody = body
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
//            guard let response = response as? HTTPURLResponse,
//                  (200...399).contains(response.statusCode) else {
//                return
//            }
            let response = response as? HTTPURLResponse
            print(response?.statusCode)
            print(String(data: data!, encoding: .utf8))

            guard let resultData = data else {
                return
            }

            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(ItemInfo.self, from: resultData) else {
                return
            }
            
            print(result)
        }
        
        task.resume()
    }
    
    func addToHTTPBody(params: [String: Any], imageData: Data) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in params {
            if key != "images" {
                body.append(boundaryPrefix.data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            } else {
                let key = "images[]"
                let filename = "image.png"
                let mimeType = "image/png"
                
                body.append(boundaryPrefix.data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
        }
        
        body.append("--".appending(boundary.appending("--")).data(using: .utf8)!)
        
        return body
    }
    
    func jsonEncode(itemInfo: ItemRegistrationForm) -> [String: Any] {
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(itemInfo),
              let result = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            return [String: Any]()
        }

        return result
    }
}
