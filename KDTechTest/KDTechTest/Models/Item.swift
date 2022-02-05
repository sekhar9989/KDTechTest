//
//  Item.swift
//  KDTechTest
//
//  Created by Sekhar Simhadri on 05/02/22.
//

import Foundation

class Item: Codable {
    let createdAt: String
    let id: Int
    let productName, unit, sku, qty: String
    let status: Int
    let image, updatedAt: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case productName = "product_name"
        case unit, sku, qty, status, image
        case updatedAt = "updated_at"
        case price
    }

    init(createdAt: String, id: Int, productName: String, unit: String, sku: String, qty: String, status: Int, image: String, updatedAt: String, price: Int) {
        self.createdAt = createdAt
        self.id = id
        self.productName = productName
        self.unit = unit
        self.sku = sku
        self.qty = qty
        self.status = status
        self.image = image
        self.updatedAt = updatedAt
        self.price = price
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

 ["trace": <__NSArrayI 0x600000da7480>(
 {
     class = "Laravel\\Lumen\\Application";
     file = "/home/ec2-user/apitest/vendor/laravel/lumen-framework/src/Concerns/RoutesRequests.php";
     function = handleDispatcherResponse;
     line = 173;
     type = "->";
 },
 {
     class = "Laravel\\Lumen\\Application";
     file = "/home/ec2-user/apitest/vendor/laravel/lumen-framework/src/Concerns/RoutesRequests.php";
     function = "Laravel\\Lumen\\Concerns\\{closure}";
     line = 429;
     type = "->";
 },
 {
     class = "Laravel\\Lumen\\Application";
     file = "/home/ec2-user/apitest/vendor/laravel/lumen-framework/src/Concerns/RoutesRequests.php";
     function = sendThroughPipeline;
     line = 175;
     type = "->";
 },
 {
     class = "Laravel\\Lumen\\Application";
     file = "/home/ec2-user/apitest/vendor/laravel/lumen-framework/src/Concerns/RoutesRequests.php";
     function = dispatch;
     line = 112;
     type = "->";
 },
 {
     class = "Laravel\\Lumen\\Application";
     file = "/home/ec2-user/apitest/public/index.php";
     function = run;
     line = 28;
     type = "->";
 }
 )
 , "line": 233, "file": /home/ec2-user/apitest/vendor/laravel/lumen-framework/src/Concerns/RoutesRequests.php, "message": , "exception": Symfony\Component\HttpKernel\Exception\NotFoundHttpException]

 Search Response:
 ["created_at": 2022-01-22T05:18:06.000000Z, "id": 297, "product_name": obat-sehat, "unit": test, "sku": OBT-001, "qty": 100, "status": 1, "image": <null>, "updated_at": 2022-01-29T22:33:41.000000Z, "price": 9000]
 */
