import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    //Configure IP And Port
    let serverConfiure = NIOServerConfig.default(hostname: "0.0.0.0", port: 9090)
    services.register(serverConfiure)

    /// Configure a PostgreSQL database
    var databases = DatabasesConfig()
    let databaseConfig = PostgreSQLDatabaseConfig(hostname: "localhost", username: "michel", database: "todoDemo1")
    let dataBase = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: dataBase, as: .psql)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .psql)
    //migrations.add(model: Todo.self, database: .psql)
    services.register(migrations)
}
