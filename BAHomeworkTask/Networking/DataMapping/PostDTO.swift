//
//  PostResponseObject.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 15.12.22.
//

import Foundation
//struct PostResponseObject: Decodable, DeserializableModel {
struct PostDTO: Decodable {
//    static func fromJSON(_ jsonData: [String : AnyObject]?) -> DeserializableModel? {
//        guard let data = jsonData,
//              let id = data["id"] as? Int,
//              let userId = data["userId"] as? Int,
//              let title = data["title"] as? String,
//              let body = data["body"] as? String
//        else {
//            print("Failed parsing PostResponseObject object from json data")
//            return nil
//        }
//
//        return PostResponseObject(userId: userId, id: id, title: title, body: body)
//    }
    /*
     {
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      },
     */
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
