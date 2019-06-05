import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  // Markdown Pages
  let mdController = MarkdownController()
  router.get("beta", use: mdController.markdownPage(filename: "beta"))

  // TODO: Abstract out a home controller
  router.get { req -> Future<View> in
    return try req.view().render("home", [Strings.titleKey: Strings.title])
  }
}
