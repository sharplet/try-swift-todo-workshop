import Vapor

final class TodoController {
  func index(_ req: Request) throws -> Future<[Todo]> {
    return Todo.query(on: req).all()
  }

  func create(_ req: Request) throws -> Future<Todo> {
    return try req.content.decode(Todo.Incoming.self).flatMap { incoming in
      incoming.makeTodo().save(on: req)
    }
  }

  func delete(_ req: Request) throws -> Future<HTTPStatus> {
    return try req.parameters.next(Todo.self).flatMap { todo in
      todo.delete(on: req)
    }.transform(to: .ok)
  }
}
