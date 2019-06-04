import Leaf
import LeafMarkdown
import Vapor

public func addTags(tagsConfig: inout LeafTagConfig) throws {
  tagsConfig.use(Markdown(), as: "markdown")
}
