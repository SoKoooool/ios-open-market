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

enum HTTPHeaderValue: String {
    case apllicationJson = "apllication/json"
    case multipartFormData = "multipart/form-data"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accept = "Accept"
}

class HTTPMethod {
    func createBoundary() -> String {
        let boundary = "Boundary-\(UUID().uuidString)"
        return boundary
    }
    
    func setHTTPHeader(url: String, method: HTTPMethodType, header: HTTPHeaderField, value: HTTPHeaderValue) -> URLRequest {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        let boundary = createBoundary()
        request.setValue("\(value); boundary=\(boundary)", forHTTPHeaderField: "\(header)")
        
        return request
    }
    
    func itemInfo() {
        let encoder = JSONEncoder()
        let itemInfo = ItemRegistrationForm(title: "", descriptions: "", price: 0, currency: "", stock: 0, discountedPrice: 0, images: [""], password: "")
        
        let data = try? encoder.encode(itemInfo)
        let str = String(data: data!, encoding: .utf8)
    }
    
    func addToHTTPBody(body: inout Data, params: [String: String]) -> Data {
        let boundary = createBoundary()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in params {
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        return body
    }
    
    func addImageToHTTPBody(body: inout Data) -> Data {
        let boundary = createBoundary()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        let imageKey = "images[]"
        let filename = "kio.gif"
        let mimeType = "image/gif"
        let imageURL = "/Users/steven/Desktop/test/kio.gif"
        let imageData = try? NSData(contentsOfFile: imageURL, options: []) as Data
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(imageData!)
        body.append("\r\n".data(using: .utf8)!)
        
        return body
    }
}
