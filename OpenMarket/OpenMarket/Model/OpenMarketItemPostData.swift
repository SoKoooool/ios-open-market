//
//  OpenMarketItemPostData.swift
//  OpenMarket
//
//  Created by TORI on 2021/05/11.
//

import Foundation

struct OpenMarketItemPostData: Codable {
    let title: String
    let descriptions: String
    let price: Int
    let currency: String
    let stock: Int
    let discounted_price: Int
    let images: [Data]
    let password: String
}
