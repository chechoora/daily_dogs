//
//  ResponseModel.swift
//  Daily Dogs Watch App
//
//  Created by Kyrylo Kharchenko on 18.09.2023.
//

import Foundation

struct FavoriteDisplayModel: Decodable {
    let id: Int
    let user_id: String
    let image_id: String
    let sub_id: String?
    let created_at: String
    let image: ImageModel?
}

struct ImageModel: Decodable {
    let id: String
    let url: String
}
