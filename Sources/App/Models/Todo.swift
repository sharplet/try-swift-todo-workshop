import FluentSQLite
import Vapor

final class Todo: SQLiteModel {
  var id: Int?
  var title: String

  init(id: Int? = nil, title: String) {
    self.id = id
    self.title = title
  }
}

/// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration {}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content {}

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter {}
