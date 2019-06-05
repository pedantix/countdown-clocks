import Leaf

enum NavBarActiveSection: String {
  case beta
}

final class NavLinkActiveTag: TagRenderer {
  func render(tag: TagContext) throws -> EventLoopFuture<TemplateData> {
    guard let tagName = tag.parameters[0].string,
      let activeTag = tag.parameters[1].string else {
        return tag.container.future(.string(""))
    }

    let activeClass: String
    if activeTag == tagName {
      activeClass = "active"
    } else {
      activeClass = ""
    }

    return tag.container.future(.string(activeClass))
  }
}
