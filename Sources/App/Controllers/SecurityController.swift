/*


import Fluent
import Vapor

struct SecurityController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let securitystatus = routes.grouped("securitystatus")
        securitystatus.get(use: index)
        securitystatus.post(use: create)
        securitystatus.put(use: update)
        securitystatus.group(":songID") { securitystatus in
            securitystatus.delete(use: delete)
        }
    }
    
    
    // GET Request /songs route
    func index(req: Request) throws -> EventLoopFuture<[SecurityStatus]> {
        return SecurityStatus.query(on: req.db).all()
    }
    
    // POST Request /songs route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let securitystatus = try req.content.decode(SecurityStatus.self)
        return securitystatus.save(on: req.db).transform(to: .ok)
    }
    
    // PUT Request /songs routes
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let securitystatus = try req.content.decode(SecurityStatus.self)
        print("Received Security Status: \(securitystatus)")
        return SecurityStatus.find(securitystatus.id, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap {
            print("Found Security Status:")
            //$0.title = securitystatus.title
            $0.status = securitystatus.status
            $0.password = securitystatus.password
            $0.checkin = securitystatus.checkin
            return $0.update(on: req.db).transform(to: .ok)
        }
    }
    
    // DELETE Request /songs/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        SecurityStatus.find(req.parameters.get("songID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}


*/


//
//  SecurityController.swift
//
//
//  Created by Ryan Smith on 2/11/24.
//

import Fluent
import Vapor

struct SecurityController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let securitystatus = routes.grouped("securitystatus")
        securitystatus.get(use: index)
        securitystatus.post(use: create)
        securitystatus.put(use: update)
        securitystatus.group(":securitystatusID") { securitystatus in
            securitystatus.delete(use: delete)
        }
    }
    
    
    // GET Request /songs route
    func index(req: Request) async throws -> [SecurityStatus] {
//        return Song.query(on: req.db).all()
        try await SecurityStatus.query(on: req.db).all()
    }
    
    // POST Request /songs route
    func create(req: Request) async throws -> HTTPStatus {
        let securitystatus = try req.content.decode(SecurityStatus.self)
//        return song.save(on: req.db).transform(to: .ok)
        
        try await securitystatus.save(on: req.db)
        return .ok
    }
    
    // PUT Request /songs routes
    func update(req: Request) async throws -> HTTPStatus {
        let securitystatus = try req.content.decode(SecurityStatus.self)
        
//        return Song.find(song.id, on: req.db)
//        .unwrap(or: Abort(.notFound))
//        .flatMap {
//            $0.title = song.title
//            return $0.update(on: req.db).transform(to: .ok)
//        }
        
        guard let InfoFromDB = try await SecurityStatus.find(securitystatus.id, on: req.db) else {
            throw Abort(.notFound)
        }
        InfoFromDB.password = securitystatus.password
        InfoFromDB.status = securitystatus.status
        try await InfoFromDB.update(on: req.db)
        return .ok
    }
    
    // DELETE Request /songs/id route
    func delete(req: Request) async throws -> HTTPStatus {
//        Song.find(req.parameters.get("songID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap { $0.delete(on: req.db) }
//            .transform(to: .ok)
        
        guard let securitystatus = try await SecurityStatus.find(req.parameters.get("securitystatusID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await securitystatus.delete(on: req.db)
        return .ok
    }
}
