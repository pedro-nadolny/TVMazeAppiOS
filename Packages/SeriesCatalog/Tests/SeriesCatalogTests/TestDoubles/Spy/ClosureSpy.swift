import Foundation

final class ClosureSpy<T> {
    private(set) var callCount = 0
    private(set) var receivedValues = [T]()
    
    private(set) lazy var closure: (T) -> Void = { value in
        self.callCount += 1
        self.receivedValues += [value]
    }
}
