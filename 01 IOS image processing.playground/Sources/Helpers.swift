import PlaygroundSupport
import Cocoa
import Metal
//import UIKit
import QuartzCore
import AppKit

public func NSImageToCIImage(image:NSImage) -> CIImage {
    var imageRect = NSRect(x: 0, y: 0, width: (image.size.width), height: (image.size.height))
    let cgImage = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
    let ciImage = CIImage(cgImage: cgImage!)
    return ciImage
}

public func saveCIImageAsPNG(_ theImage: CIImage, toPath: URL) {
    let bitmap = NSBitmapImageRep(ciImage: theImage) as NSBitmapImageRep
    let pngData = bitmap.representation(using: NSPNGFileType, properties: [:])
    do {
        try pngData?.write(to: toPath)
    } catch {
        print("Error writing PNG data to file path \(toPath): \(error)")
    }
}


public func NSImageFromCIImage(_ theCIImage: CIImage) -> NSImage {
    let rep = NSCIImageRep(ciImage:theCIImage)
    let newImage = NSImage(size: rep.size)
    newImage.addRepresentation(rep)
    return newImage
}

public func CIImageFromNSImage(_ inputImage: NSImage) ->CIImage? {
    if let imageData = inputImage.tiffRepresentation,
        let bitmap = NSBitmapImageRep(data: imageData) {
        return CIImage(bitmapImageRep: bitmap)
    }
    return nil
}


public extension NSImage {
    @discardableResult
    public func pngWrite(url: URL) -> Bool {
        guard let tiffData = self.tiffRepresentation else {
            print("failed to get tiffRepresentation. url: \(url)")
            return false
        }
        let imageRep = NSBitmapImageRep(data: tiffData)
        guard let imageData = imageRep?.representation(using: .PNG, properties: [:]) else {
            print("failed to get PNG representation. url: \(url)")
            return false
        }
        do {
            print("Writing url: \(url)")
            try imageData.write(to: url)
            return true
        } catch {
            print("failed to write to disk. url: \(url)")
            return false
        }
    }
}


//extension NSBitmapImageRep {
//    var png: Data? {
//        return representation(using: .PNG, properties: [:])
//    }
//}
//extension Data {
//    var bitmap: NSBitmapImageRep? {
//        return NSBitmapImageRep(data: self)
//    }
//}
//extension NSImage {
//    var png: Data? {
//        return tiffRepresentation?.bitmap?.png
//    }
//    func savePNG(to url: URL) -> Bool {
//        do {
//            try png?.write(to: url)
//            return true
//        } catch {
//            print(error)
//            return false
//        }
//        
//    }
//}

//let picture  = NSImage(contentsOf: URL(string: "https://i.stack.imgur.com/Xs4RX.jpg")!)!
//
//let imageURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!.appendingPathComponent("image.png")
//if picture.savePNG(to: imageURL) {
//    print("image saved as PNG")
//}
//

public func loadImageByPathAsCIImage(p:String ) -> CIImage {
    print ("Loading \(p)")
    let image = NSImage(contentsOfFile: p)
    var imageRect = NSRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
    let cgImage = image?.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
    let ciImage = CIImage(cgImage: cgImage!)
    return ciImage
}

    
public func loadImageByPathAsNSImage(p:String ) -> NSImage {
    print ("Loading \(p)")
    let image = NSImage(contentsOfFile: p)
    return image!
}
    
public func getCIFilterByName(n:String) -> CIFilter{
    let filter = CIFilter(name:n)!
    return filter
}


public func executionTimeInterval(block: () -> ()) -> CFTimeInterval {
    let start = CACurrentMediaTime()
    block();
    let end = CACurrentMediaTime()
    return end - start
}


// Non-memoized Fibonacci generator
public func fib(n: Int) -> Int {
    assert(n >= 0)
    switch n {
    case 0, 1: return 1
    default:   return fib(n: n-1) + fib(n: n-2)
    }
}


class ParkBenchTimer {
    
    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?
    
    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()
        
        return duration!
    }
    
    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}


