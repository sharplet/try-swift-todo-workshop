struct NilError: Error {
  var message: String?
}

extension Optional {
  func unwrap(_ message: @autoclosure () -> String? = nil) throws -> Wrapped {
    if let wrapped = self {
      return wrapped
    } else {
      throw NilError(message: message())
    }
  }
}
