//
//  CreateSecurity.swift
//  
//
//  Created by Ryan Smith on 2/11/24.
//

import Fluent

struct CreateSecurity: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("securitystatus")
            .id()
            .field("status", .string)
            .field("password", .string)
            .field("checkin", .string)
            //.field("title", .string)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("securitystatus").delete()
    }
}
