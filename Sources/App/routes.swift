import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
      return try req.view().render("home", ["name": "Shaun", "title": "Welcome to Countdown Clocks"])
    }

    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
}
