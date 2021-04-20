//
// Created by Serghei Grigoruta on 17.04.2021.
//

class Evaluator {
    private var root: BoundExpression

    init(root: BoundExpression) {
        self.root = root
    }

    func evaluate() -> Any {
        try! evaluateExpression(node: root)
    }

    func evaluateExpression(node: BoundExpression) throws -> Any {
        if let n = node as? BoundLiteralExpression {
            return n.value
        }

        if let u = node as? BoundUnaryExpression {
            let operand = try evaluateExpression(node: u.operand)

            switch u.op.kind {
            case .identity:
                return operand as! Int
            case .negation:
                return -(operand as! Int)
            case .logicalNegation:
                return !(operand as! Bool)
            }
        }

        if let b = node as? BoundBinaryExpression {
            let left = try evaluateExpression(node: b.left)
            let right = try evaluateExpression(node: b.right)

            switch b.op.kind {
            case .addition:
                return (left as! Int) + (right as! Int)
            case .subtraction:
                return (left as! Int) - (right as! Int)
            case .multiplication:
                return (left as! Int) * (right as! Int)
            case .division:
                return (left as! Int) / (right as! Int)
            case .logicalAnd:
                return (left as! Bool) && (right as! Bool)
            case .logicalOr:
                return (left as! Bool) || (right as! Bool)
            }
        }

        fatalError("Unexpected node: '\(node.kind)'")
    }
}
