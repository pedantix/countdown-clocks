#if os(Linux)

import XCTest
@testable import AppTests

XCTMain([
    // MarkdownControllerTests
    testCase(MarkdownControllerTests.allTests),
    testCase(NavLinkActiveTagTests.allTests)
])

#endif
