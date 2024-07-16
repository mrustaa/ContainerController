

import Foundation

public func background(work: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        work()
    }
}

public func main(work: @escaping () -> Void) {
    DispatchQueue.main.async {
        work()
    }
}

public func main(delay: Double, work: @escaping () -> Void) {
    let deadline = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: deadline) {
        work()
    }
}
