import Vapor
import Leaf
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  // Register providers first
  try services.register(FluentPostgreSQLProvider())
  try services.register(LeafProvider())
  config.prefer(LeafRenderer.self, for: ViewRenderer.self)

  // Register routes to the router
  let router = EngineRouter.default()
  routes(router)
  services.register(router, as: Router.self)

  // Configure Middleware
  try addMiddleware(&services)

  // Register the configured SQLite database to the database config.
  var databasesConfig = DatabasesConfig()
  try databases(config: &databasesConfig)
  services.register(databasesConfig)

  // Configure migrations
  services.register { _ -> MigrationConfig in
    var migrationConfig = MigrationConfig()
    try migrate(migrations: &migrationConfig)
    return migrationConfig
  }

  // Leaf
  var tagsConfig = LeafTagConfig.default()
  try addTags(tagsConfig: &tagsConfig)
  services.register(tagsConfig)
}
