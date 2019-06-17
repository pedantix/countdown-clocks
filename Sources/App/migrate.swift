import Vapor
import FluentPostgreSQL //use your database driver here

public func migrate(migrations: inout MigrationConfig) throws {
  migrations.add(model: CountdownEvent.self, database: .psql) 
}
