//
//  DishesTarget.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Foundation
import Moya

enum DishesTarget {
    case dishes
}

extension DishesTarget: TargetType {
    /// Возвращает базовую часть URL для запроса
    var baseURL: URL {
        URL(string: "http://127.0.0.1:8080")! // swiftlint:disable:this force_unwrapping
    }

    /// Путь
    var path: String {
        switch self {
        case .dishes:
            "/Dishes"
        }
    }

    /// HTTP Метод
    var method: Moya.Method {
        switch self {
        case .dishes:
                .get
        }
    }

    /// HTTP таска
    var task: Moya.Task {
        switch self {
        case .dishes:
                .requestPlain
        }
    }

    /// Словарь заголовков
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
