import PlaygroundSupport
import Cocoa
import Metal
import QuartzCore

//See http://alexsosn.github.io/ml/2015/11/19/metal_gpgpu.html

public func executionTimeInterval(block: () -> ()) -> CFTimeInterval {
    let start = CACurrentMediaTime()
    block();
    let end = CACurrentMediaTime()
    return end - start
}

public func myVector(len: Int) -> [Float] {
    var myvector = [Float](repeating: 0, count: len)
    
    for (index, _) in myvector.enumerated() {
        myvector[index] = Float(index)
    }
    return myvector
}

/// Playground helper: produce the value of `expr`, or print the given `message` and exit.
/// If `expr` throws an error, the error is also printed.
public func require<T>(_ expr: @autoclosure () throws -> T?, orDie message: @autoclosure () -> String) -> T
{
    do {
        if let result = try expr() { return result }
        else { print(message()) }
    }
    catch {
        print(message())
        print("error: \(error)")
    }
    PlaygroundPage.current.finishExecution()
}
