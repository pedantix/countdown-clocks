import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) {
  MarkdownController.mount(to: router)
  CountdownEventsController.mount(to: router)
}
