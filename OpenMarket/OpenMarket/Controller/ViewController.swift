//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test_HTTP_POST()
    }
    
    func test_HTTP_POST() {
//        let encoder = JSONEncoder()
//        let image = UIImage(systemName: "pencil")
//        let imgData = image?.jpegData(compressionQuality: 0.1)
//
//        let json = OpenMarketItemPostData(title: "스티븐 무료", descriptions: "스티븐 멈춰!", price: 0, currency: "KRW", stock: 1, discounted_price: 0, images: [imgData!], password: "1234")
//
//        guard let jsonData = try? encoder.encode(json) else {
//            return
//        }
//
//        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
//            return
//        }

        guard let url = URL(string: "https://camp-open-market-2.herokuapp.com/item") else {
            return
        }
        
        let body = """
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="title"

        스티븐 무료
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="descriptions"

        스티븐 멈춰!
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="price"

        0
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="currency"

        KRW
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="stock"

        1
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="password"

        1234
        ----WebKitFormBoundary7MA4YWxkTrZu0gW
        Content-Disposition: form-data; name="images[]"; filename="kio.png"
        Content-Type: image/png


        """
        let body2 = "----WebKitFormBoundary7MA4YWxkTrZu0gW--"
        
        let imageUrl = "/Users/sjsj/Downloads/kio.png"
        guard let imageData = NSData(contentsOfFile: imageUrl) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body.data(using: .utf8)

        request.httpBody?.append(imageData as Data)
        request.httpBody?.append("\r\n".data(using: .utf8)!)
        request.httpBody?.append(body2.data(using: .utf8)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
        }
        task.resume()
    }

}

