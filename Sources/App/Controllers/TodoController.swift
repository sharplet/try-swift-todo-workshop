import Vapor

final class TodoController {
  func index(_ req: Request) throws -> Future<[Todo.Outgoing]> {
    return Todo.query(on: req).all().map { todos in
      todos.map { $0.makeOutgoing(with: req) }
    }
  }

  func view(_ req: Request) throws -> Future<Todo.Outgoing> {
    return try req.parameters.next(Todo.self).map { $0.makeOutgoing(with: req) }
  }

  func create(_ req: Request) throws -> Future<Todo.Outgoing> {
    return try req.content.decode(Todo.Incoming.self).flatMap { incoming in
      incoming.makeTodo().save(on: req).map { $0.makeOutgoing(with: req) }
    }
  }

  func clear(_ req: Request) throws -> Future<HTTPStatus> {
    return Todo.query(on: req).delete().transform(to: .ok)
  }

  func delete(_ req: Request) throws -> Future<HTTPStatus> {
    return try req.parameters.next(Todo.self).flatMap { todo in
      todo.delete(on: req)
    }.transform(to: .ok)
  }
}
