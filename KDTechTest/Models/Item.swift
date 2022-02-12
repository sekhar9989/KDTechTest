//
//  Item.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import Foundation

class Item: Codable {
    let id: Int
    let sku, productName: String
    let qty, price: Int
    let unit: String
    let status: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, sku
        case productName = "product_name"
        case qty, price, unit, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, sku: String, productName: String, qty: Int, price: Int, unit: String, image: String, status: Int, createdAt: String, updatedAt: String) {
        self.id = id
        self.sku = sku
        self.productName = productName
        self.qty = qty
        self.price = price
        self.unit = unit
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

/*
 Signup response:

 ["success": 1, "data": {
     "created_at" = "2022-02-05T06:07:44.000000Z";
     email = "abc@abc.abc";
     id = 287;
     "updated_at" = "2022-02-05T06:07:44.000000Z";
 }, "message": Success register!]

 SignIn Response:
 {
     "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJiZWFyZXIiLCJzdWIiOjMwMiwiaWF0IjoxNjQ0NTUyNDUwLCJleHAiOjE2NDQ1NTYwNTB9.1PZneeMLE8IKlJuC-lUGwZ_ZtzydCHN4vCwBCOUyhKs"
 }

 Search Response:
 ["created_at": 2022-01-22T05:18:06.000000Z, "id": 297, "product_name": obat-sehat, "unit": test, "sku": OBT-001, "qty": 100, "status": 1, "image": <null>, "updated_at": 2022-01-29T22:33:41.000000Z, "price": 9000]
 */
