import FluentPostgreSQL

final class CountdownEvent: PostgreSQLModel {
  var id: Int?

  // Mandatory Fields!
  var title: String
  var date: Date
  // A hashed string for obfuscating the id
  var identifier: String

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
      builder.field(for: \.createdAt)
      builder.field(for: \.updatedAt)

      builder.unique(on: \.identifier)
    }
  }
}
