//
//  HomeCategoriesAPI.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 28.11.2024.
//

import Combine
import CombineMoya
import Foundation
import Moya

enum HomeCategoriesAPI {
    case fetchCategories
}

extension HomeCategoriesAPI: TargetType {
    var baseURL: URL {
        URL(string: "http://127.0.0.1:8080")! // swiftlint:disable:this force_unwrapping
    }

    var path: String {
        switch self {
        case .fetchCategories:
            "/categories"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchCategories:
            .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .fetchCategories:
            .requestPlain
        }
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
