import Vapor

final class CountdownEventsController {
  static func mount(to router: Router) {
    let controller = CountdownEventsController()

    router.get("", use: controller.home)
    router.post(CountdownEvent.self, at: "", use: controller.create)
  }

  func home(_ req: Request) throws -> Future<View> {
    let logger: Logger = try req.make()
    if #available(OSX 10.12, *) {
      logger.debug("iso date \(ISO8601DateFormatter().string(from: Date()))")
    } else {
      // Fallback on earlier versions
    }
    return try req.view().render("home", [Strings.titleKey: Strings.title])
  }

  func create(_ req: Request, event: CountdownEvent) throws -> Future<CountdownEvent> {
    try event.validate()

    return event.save(on: req)
  }
}

