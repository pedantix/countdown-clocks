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

  // Register middleware
  var middlewares = MiddlewareConfig() // Create _empty_ middleware config
  middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
  middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
  services.register(middlewares)

  // Register the configured SQLite database to the database config.
  var databasesConfig = DatabasesConfig()
  try databases(config: &databasesConfig)
  services.register(databasesConfig)

  // Configure migrations
  services.register { container -> MigrationConfig in
    var migrationConfig = MigrationConfig()
    try migrate(migrations: &migrationConfig)
    return migrationConfig
  }

  // Leaf
  var tagsConfig = LeafTagConfig.default()
  try addTags(tagsConfig: &tagsConfig)
  services.register(tagsConfig)
}
