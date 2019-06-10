//
//  Application+Testing.swift
//  AppTests
//
//  Created by Shaun Hubbard on 6/7/19.
//

import Vapor
@testable import App
// Test helpers from:
// https://medium.com/swift2go/vapor-3-series-iii-testing-b192be079c9e

extension Application {
  static func easyTestable() throws -> Application {
    var config = Config.default()
    var services = Services.default()
    var env = Environment.testing
    try App.configure(&config, &env, &services)
    let app = try Application(config: config, environment: env, services: services)
    try App.boot(app)

    return app
  }
}

extension Application {
  func sendRequest<Body>(
    to path: String,
    method: HTTPMethod,
    headers: HTTPHeaders = .init(),
    body: Body?,
    isLoggedInRequest: Bool = false
  ) throws -> Response where Body: Content {
    let headers = headers

    /*
     if isLoggedInRequest {
     let credentials = BasicAuthorization(username: "admin", password: "password")
     var tokenHeaders = HTTPHeaders()
     tokenHeaders.basicAuthorization = credentials
     let tokenBody: EmptyBody? = nil
     let tokenResponse = try sendRequest(to: "api/users/login", method: .POST, headers: tokenHeaders, body: tokenBody)
     let token = try tokenResponse.content.decode(Token.self).wait()
     headers.add(name: .authorization, value: "Bearer \(token.token)")
     }*/

    let httpRequest = HTTPRequest(method: method, url: URL(string: path)!, headers: headers)
    let wrappedRequest = Request(http: httpRequest, using: self)
    if let body = body {
      try wrappedRequest.content.encode(body)
    }
    let responder = try make(Responder.self)

    return try responder.respond(to: wrappedRequest).wait()
  }
}

struct EmptyBody: Content {}
