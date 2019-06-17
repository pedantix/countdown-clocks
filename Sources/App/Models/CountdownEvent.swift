import Vapor
import FluentPostgreSQL
import Validation
import Crypto

final class CountdownEvent: PostgreSQLModel {
  var id: Int?

  // TODO: Validate the following
  // Mandatory Fields!
  var title: String?
  var date: Date?

  // A hashed string for obfuscating the id
  var identifier: String?

  // Optional Fields
  var titleColor: String?
  var subtitle: String?
  var subtitleColor: String?
  var backgroundColor: String?
  var backgroundImage: String?

  static let createdAtKey: TimestampKey? = \.createdAt
  static let updatedAtKey: TimestampKey? = \.updatedAt

  var createdAt: Date?
  var updatedAt: Date?
}

extension CountdownEvent: Migration {
  static func prepare(on conn: PostgreSQLConnection) -> Future<Void> {
    return Database.create(CountdownEvent.self, on: conn) { builder in
      builder.field(for: \.id, isIdentifier: true)
      builder.field(for: \.title)
      builder.field(for: \.date)
      builder.field(for: \.identifier)
      builder.field(for: \.titleColor)
      builder.field(for: \.subtitle)
      builder.field(for: \.subtitleColor)
      builder.field(for: \.backgroundColor)
      builder.field(for: \.backgroundImage)

      // Internal use
      builder.field(for: \.createdAt)
      builder.field(for: \.updatedAt)
      builder.unique(on: \.identifier)
    }
  }
}

extension CountdownEvent {
  func willCreate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<CountdownEvent> {
    self.identifier = UUID().uuidString.replacingOccurrences(of: "-", with: "") // create an opaque identifier
    return conn.future(self)
  }
}

extension CountdownEvent: Content { }

extension CountdownEvent: Validatable {
  static func validations() throws -> Validations<CountdownEvent> {
    var validations = Validations(CountdownEvent.self)
    try validations.add(\CountdownEvent.title, .count(3...) && !.nil)
    try validations.add(\CountdownEvent.subtitle, .count(3...) || .nil)
    // Colors should validate that they are all HEXS
    try validations.add(\CountdownEvent.titleColor, .count(6...6) || .nil)
    try validations.add(\CountdownEvent.subtitleColor, .count(6...6) || .nil)
    try validations.add(\CountdownEvent.titleColor, .count(6...6) || .nil)
    return validations
  }
}
