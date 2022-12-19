//
//  NetworkerHelpers.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 19.12.22.
//

import Foundation
protocol DeserializableModel {
    static func fromJSON(_ jsonData: [String: AnyObject]?) -> DeserializableModel?
}

extension DeserializableModel {
    static func buildArray(_ jsonData: [[String: AnyObject]]?) -> [Self] {
        var array: [Self] = []
        guard let jsonData = jsonData else { return array }

        for tData in jsonData {
            guard let tElement = Self.fromJSON(tData) as? Self else { continue }
            array.append(tElement)
        }
        return array
    }
}
