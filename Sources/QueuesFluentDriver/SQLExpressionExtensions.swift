import Fluent
import SQLKit

enum SQLForUpdateSkipLocked: SQLExpression {
    case forUpdateSkipLocked
    
    public func serialize(to serializer: inout SQLSerializer) {
        switch self {
            case .forUpdateSkipLocked:
                serializer.write("FOR UPDATE SKIP LOCKED")
        }
    }
}

// We're really abusing here but not sure how to do it in a cleaner way
enum SQLReturning: SQLExpression {
    /// `RETURNING *`
    case returningAll
    case returning(column: FieldKey)
    
    public func serialize(to serializer: inout SQLSerializer) {
        switch self {
            case .returningAll:
                serializer.write("1=2 RETURNING *")
            case .returning(let column):
                serializer.write("1=2 RETURNING \"\(column.description)\"")
        }
    }
}