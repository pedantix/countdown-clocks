import Vapor

final class MarkdownController {
  func markdownPage(filename: String) -> (Request) throws -> Future<View> {
    return { request in
      let dirs = try request.make(DirectoryConfig.self)
      let path = dirs.workDir + "Resources/Markdown/beta.md"
      guard let data = FileManager.default.contents(atPath: path),
        let content = String(data: data, encoding: .utf8)
        else { throw Abort(.serviceUnavailable) }
      return try request.view().render("beta", [
        Strings.titleKey: Strings.title,
        Strings.contentKey: content,
        Strings.activeTabKey: NavBarActiveSection.beta.rawValue])
    }
  }
}
