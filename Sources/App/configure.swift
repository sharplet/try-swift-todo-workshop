import FluentPostgreSQL
import Vapor

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  /// Register providers first
  try services.register(FluentPostgreSQLProvider())

  services.register { container -> CommandConfig in
    var config = CommandConfig.default()
    config.useFluentCommands()
    return config
  }

  /// Register routes to the router
  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)

  // CORS config
  let cors = CORSMiddleware(configuration: .init(
    allowedOrigin: .all, // FIXME: not in production!
    allowedMethods: [.GET, .POST, .DELETE, .OPTIONS, .PATCH],
    allowedHeaders: [.xRequestedWith, .origin, .contentType, .accept]
  ))

  /// Register middleware
  var middlewares = MiddlewareConfig()
  middlewares.use(cors)
  middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
  services.register(middlewares)

  // Configure a SQLite database
  let databaseURL = try Environment.get("DATABASE_URL").unwrap("Missing DATABASE_URL")
  let config = try PostgreSQLDatabaseConfig(url: databaseURL).unwrap("Invalid DATABASE_URL \(databaseURL)")
  let postgres = PostgreSQLDatabase(config: config)

  /// Register the configured SQLite database to the database config.
  var databases = DatabasesConfig()
  databases.add(database: postgres, as: .psql)
  services.register(databases)

  /// Configure migrations
  var migrations = MigrationConfig()
  migrations.add(model: Todo.self, database: .psql)
  services.register(migrations)
}
