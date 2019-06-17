import Vapor

final class CountdownEventsController {
  static func mount(to router: Router) {
    let controller = CountdownEventsController()

    router.get("", use: controller.home)
  }

  func home(_ req: Request) throws -> Future<View> {
    return try req.view().render("home", [Strings.titleKey: Strings.title])
  }
}

