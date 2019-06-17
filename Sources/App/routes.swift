import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) {
  // Markdown Pages
  let mdController = MarkdownController()
  router.get("beta", use: mdController.markdownPage(filename: "beta"))

  CountdownEventsController.mount(to: router)
}
