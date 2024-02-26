//
//  SecurityStatus.swift
//  
//
//  Created by Ryan Smith on 2/11/24.
//

import Fluent
import Vapor

final class SecurityStatus: Model, Content {
    static let schema = "securitystatus"
    
    @ID(key: .id)
    var id: UUID?
    //@Field(key: "title")
    //var title: String
    @Field(key: "status")
    var status: String
    @Field(key: "password")
    var password: String
    @Field(key: "checkin")
    var checkin: String
    init() { }
    
    init(id: UUID? = nil, status: String, password: String, checkin: String) {
        self.id = id
        self.status = status
        self.password = password
        //self.title = title
        self.checkin = checkin
    }
}
