//
//  Vehicle.swift
//  webmotors
//
//  Created by Nikita Fedorenko on 17.12.2021.
//

import Foundation

struct Vehicle: Decodable{
    
    let color: String
    let id: Int
    let image: String
    let km: Int
    let make: String
    let model: String
    let price: String
    let version: String
    let yearFab: Int
    let yearModel: Int
    
    enum CodingKeys: String, CodingKey{
        case color = "Color"
        case id = "ID"
        case image = "Image"
        case km = "KM"
        case make = "Make"
        case model = "Model"
        case price = "Price"
        case version = "Version"
        case yearFab = "YearFab"
        case yearModel = "YearModel"
    }
}
