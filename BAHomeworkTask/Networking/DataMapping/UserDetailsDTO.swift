//
//  UserDetail.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 15.12.22.
//

import Foundation

/*
 {
 "id": 1,
 "name": "Leanne Graham",
 "username": "Bret",
 "email": "Sincere@april.biz",
 "address": {
 "street": "Kulas Light",
 "suite": "Apt. 556",
 "city": "Gwenborough",
 "zipcode": "92998-3874",
 "geo": {
 "lat": "-37.3159",
 "lng": "81.1496"
 }
 },
 "phone": "1-770-736-8031 x56442",
 "website": "hildegard.org",
 "company": {
 "name": "Romaguera-Crona",
 "catchPhrase": "Multi-layered client-server neural-net",
 "bs": "harness real-time e-markets"
 }
 }
 */

struct UserDetailsDTO: Decodable, DeserializableModel {

    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    static func fromJSON(_ jsonData: [String : AnyObject]?) -> DeserializableModel? {
        guard let jsonData = jsonData,
              let id = jsonData["id"] as? Int,
              let name = jsonData["name"] as? String,
              let username = jsonData["username"] as? String,
              let email = jsonData["email"] as? String,
              let addressJsonData = jsonData["address"] as? [String: AnyObject],
              let address = Address.fromJSON(addressJsonData) as? Address,
              let phone = jsonData["phone"] as? String,
              let website = jsonData["website"] as? String,
              let companyJsonData = jsonData["company"] as? [String: AnyObject],
              let company = Company.fromJSON(companyJsonData) as? Company
        else {
            return nil
        }
        return  UserDetailsDTO.init(id: id,
                                    name: name,
                                    username: username,
                                    email: email,
                                    address: address,
                                    phone: phone,
                                    website: website,
                                    company: company)
    }
}

struct Address: Decodable, DeserializableModel {
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    static func fromJSON(_ jsonData: [String : AnyObject]?) -> DeserializableModel? {
        guard let data = jsonData,
              let street = data["street"] as? String,
              let suite = data["suite"] as? String,
              let city = data["city"] as? String,
              let zipcode = data["zipcode"] as? String,
              let geoJsonData = data["geo"] as? [String: AnyObject],
              let geo = Geo.fromJSON(geoJsonData) as? Geo
        else {
            print("Failed parsing CaseStudySection object from json data")
            return nil
        }
        
        return Address(street: street,
                       suite: suite,
                       city: city,
                       zipcode: zipcode,
                       geo: geo)
    }
}

struct Geo: Decodable, DeserializableModel {

    let lat: String
    let lng: String
    
    static func fromJSON(_ jsonData: [String : AnyObject]?) -> DeserializableModel? {
        guard let jsonData = jsonData,
              let lat = jsonData["lat"] as? String,
              let lng = jsonData["lng"] as? String
        else {
            print("Failed parsing Geo object from json data")
            return nil
        }
        
        return Geo(lat: lat, lng: lng)
    }
}

struct Company: Decodable, DeserializableModel {
    
    let name: String
    let catchPhrase: String
    let bs: String
    
    static func fromJSON(_ jsonData: [String : AnyObject]?) -> DeserializableModel? {
        guard let jsonData = jsonData,
              let name = jsonData["name"] as? String,
              let catchPhrase = jsonData["catchPhrase"] as? String,
              let bs = jsonData["bs"] as? String
        else {
            print("Failed parsing Company object from json data")
            return nil
        }
        
        return Company(name: name, catchPhrase: catchPhrase, bs: bs)
    }
}


