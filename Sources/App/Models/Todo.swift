import FluentPostgreSQL
import Vapor

struct Todo: PostgreSQLModel {
  var id: Int?
  var title: String
  var completed: Bool
  var order: Int?
}

/// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration {}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content {}

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter {}
