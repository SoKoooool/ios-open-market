//
//  OpenMarketTests.swift
//  OpenMarketTests
//
//  Created by TORI on 2021/05/10.
//

import XCTest
@testable import OpenMarket

class OpenMarketTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_URL요청하기() {
        let url = URL(string: "https://camp-open-market-2.herokuapp.com/items/1")
        let response = try? String(contentsOf: url!)
        XCTAssertNotNil(response)
    }
    
    func test_아이템을_받아왔는지_확인() {
        guard let url = URL(string: "https://camp-open-market-2.herokuapp.com/items/1") else {
            XCTFail()
            return
        }
        
        guard let data = try? String(contentsOf: url).data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(OpenMarketItemsList.self, from: data) else {
            XCTFail()
            return
        }

        XCTAssertEqual(result.page, 1)
        XCTAssertEqual(result.items.count, 20)
        XCTAssertEqual(result.items[0].id, 43)
        XCTAssertEqual(result.items[0].stock, 5000000)
        XCTAssertEqual(result.items[0].currency, "USD")
        XCTAssertEqual(result.items[0].title, "Apple Pencil")
        XCTAssertEqual(result.items[0].price, 165)
        XCTAssertEqual(result.items[0].discounted_price, 160)
        XCTAssertEqual(result.items[0].registration_date, 1620633347.3906322)
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
            XCTFail()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body.data(using: .utf8)
        request.httpBody?.append(imageData as Data)
        request.httpBody?.append("\r\n".data(using: .utf8)!)
        request.httpBody?.append(body2.data(using: .utf8)!)
        
        let promise = expectation(description: "Status code: 200")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                XCTFail()
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                XCTAssertNil(String(decoding: data!, as: UTF8.self))
                XCTAssertEqual(statusCode, 200)
                promise.fulfill()
            }
        }
        task.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func test_Http_DELETE_메소드_보내기() {
            guard let url = URL(string: "https://camp-open-market-2.herokuapp.com/item/83")
            else { XCTFail(); return }
            
            let promise = expectation(description: "Status code: 200")
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.httpBody = "{ \"password\": \"123\" }".data(using: .utf8)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    XCTFail()
                    return
                }
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    XCTAssertEqual(statusCode, 200)
                    promise.fulfill()
                }
            }.resume()
            
            wait(for: [promise], timeout: 2)
        }
}
