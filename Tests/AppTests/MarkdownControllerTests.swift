//
//  MarkdownControllerTests.swift
//  App
//
//  Created by Shaun Hubbard on 6/7/19.
//

import Foundation
import XCTest
@testable import Vapor

final class MarkdownControllerTests: XCTestCase {
  var app: Application!

  override func setUp() {
    super.setUp()
    app = try! Application.easyTestable()
  }

  func testBeta() throws {
    let http = try app.sendRequest(to: "/beta", method: .GET, body: EmptyBody()).http
    XCTAssertEqual(http.status, .ok)

    let bodyText = http.description
    XCTAssertTrue(bodyText.contains("<!DOCTYPE html>"))
    XCTAssertTrue(bodyText.contains("<html>"))
    XCTAssertTrue(bodyText.contains("</html>"))
    XCTAssertTrue(bodyText.contains("<h4>Data Volatility Statement</h4>"), "test that markdown is being processed as expected")
  }

  static let allTests = [
    ("testBeta", testBeta)
  ]
}


