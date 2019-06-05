import XCTest
import Vapor

@testable import App
@testable import Leaf

final class NavLinkActiveTagTests: XCTestCase {
  var renderer: LeafRenderer!
  var template: String = ""

  override func setUp() {
    let queue = EmbeddedEventLoop()
    let container = BasicContainer(config: .init(), environment: .testing, services: .init(), on: queue)
    var leafTagConfig = LeafTagConfig.default()
    try? addTags(tagsConfig: &leafTagConfig)
    self.renderer = LeafRenderer(config: LeafConfig(tags: leafTagConfig, viewsDir: "", shouldCache: false),
                                 using: container)
  }

  func testEmptyCase() throws {
    template = "<h1>#navLinkActive()</h1>"
    let data = TemplateData.dictionary([:])
    let expectedHtml = "<h1></h1>"
    let result = try renderer.render(template: template.data(using: .utf8)!, data).wait()
    let resultString = String(data: result.data, encoding: .utf8)!
    XCTAssertEqual(resultString, expectedHtml)
  }

  func testMatchingCase() throws {
    template = """
    <h1>#navLinkActive("t", imp)</h1>
    """
    let data = TemplateData.dictionary(["imp": .string("t")])
    let expectedHtml = "<h1>active</h1>"
    let result = try renderer.render(template: template.data(using: .utf8)!, data).wait()
    let resultString = String(data: result.data, encoding: .utf8)!
    XCTAssertEqual(resultString, expectedHtml)
  }

  func testNonMatchingCase() throws {
    template = """
    <h1>#navLinkActive("f", imp)</h1>
    """
    let data = TemplateData.dictionary(["imp": .string("t")])
    let expectedHtml = "<h1></h1>"
    let result = try renderer.render(template: template.data(using: .utf8)!, data).wait()
    let resultString = String(data: result.data, encoding: .utf8)!
    XCTAssertEqual(resultString, expectedHtml)
  }

  static var allTests = [
    ("testEmptyCase", testEmptyCase),
    ("testMatchingCase", testMatchingCase),
    ("testNonMatchingCase", testNonMatchingCase)
  ]
}
