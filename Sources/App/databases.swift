import Vapor
import PostgreSQL

public func databases(config: inout DatabasesConfig) throws {
  let postgreSQLDatabaseConfig: PostgreSQLDatabaseConfig
  if let databaseUrl = Environment.get("DB_POSTGRESQL") {
    guard let dbConfig = PostgreSQLDatabaseConfig(url: databaseUrl) else { throw Abort(.internalServerError) }
    postgreSQLDatabaseConfig = dbConfig
  } else {
    postgreSQLDatabaseConfig = PostgreSQLDatabaseConfig(
      hostname: "localhost",
      username: "vapor",
      database: "countdownclocks"
    )
  }
  config.add(database: PostgreSQLDatabase(config: postgreSQLDatabaseConfig), as: .psql)
}
