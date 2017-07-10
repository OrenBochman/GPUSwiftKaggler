import Cocoa
import Accelerate
import Metal
import MetalKit
import Foundation

/*:
 ![](badge_1.png)
 
 ## Swift playground: Metal GPU Machine Learning and Image Processing on OSX/IOS
 
 *[Shlomo Kashani](shlomokashani@gmail.com), July 2017*
 
 *July 2017: [Created for Swift 3.1 / Xcode 9.1 Beta](https://github.com/QuantScientist)*

 
 This playground provides an interactive depiction of how to use Metal/Accelerate Frameworks to run basic Image Processing and Machine Learning pipelines.
 
 - Experiment: Click on the rendered Iris Images to view them Inline.
 
 - Note: To see the playground output, click the Assistant Editor button in the toolbar, or press ⌥⌘↩, which should display the Timeline. 
 
 - Note: This demo only covers using Metal / Accelerate for **compute functions**.
 */

func sigmoid(x: Float) -> Float {
    return 1 / (1 + exp(-x))
}

for count in -10...10 {
    sigmoid(x: Float(count))
}

// can be loaded from resources folder
let iris1NSImage=NSImage(named: "iris1")


let iris2NSImage=NSImage(named: "iris2")



let iris1CIImage:CIImage=NSImageToCIImage(image: iris1NSImage!)

/*:
 ### Monochrome filter
 - Experiment: Click on the rendered Iris Images to view them Inline.
 */
let monochromeFilter = CIFilter(name: "CIPhotoEffectTonal")!
monochromeFilter.setValue(iris1CIImage, forKey: kCIInputImageKey)
let outputCIImagemonochromeFilter = monochromeFilter.outputImage
/*:
 ### Gaussian Blur filter
 - Experiment: Click on the rendered Iris Images to view them Inline.
 */

var inputRadius:CGFloat = 3
var blurFilter = CIFilter(name: "CIGaussianBlur",
                    withInputParameters:["inputImage" : outputCIImagemonochromeFilter!,
                                         "inputRadius":inputRadius])!
let outputCIImageblurFilter = blurFilter.outputImage

/*:
 ### Edge filter
 - Experiment: Click on the rendered Iris Images to view them Inline.
 */
let edgesFilter = CIFilter(name: "CIEdges")!
edgesFilter.setValue(outputCIImageblurFilter!, forKey: kCIInputImageKey)
let outputImageUncropped = edgesFilter.outputImage!

/*:
 ### Save image to hard drive
 - Experiment: Click on the rendered Iris Images to view them Inline.
 */

let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
let destinationURL = desktopURL.appendingPathComponent("my-image.png")

//saveCIImageAsPNG(outputImageUncropped, toPath:destinationURL)

let nsImage=NSImageFromCIImage(outputImageUncropped)
if nsImage.pngWrite(url: destinationURL) {
    print("File saved")
}

//let iris3NSImage=NSImage(named: "iris2")
//let nsImage=iris3NSImage!
//
//if nsImage.pngWrite(url: destinationURL) {
//    print("File saved")
//}


//let outputImage = edgesFilter.value(forKey: "outputImage") as! CIImage
//let context = CIContext()
//let outputImage2=context.createCGImage(outputImage, from: outputImage.extent)!

//let iris2CIImage:CIImage=NSImageToCIImage(image: iris2NSImage!)

//let fileURL = Bundle.main.url(forResource: "gt", withExtension: "ipynb")
//let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

//let context = CIContext()
//let cgImage = context.createCGImage(outputImageUncropped, from: outputImageUncropped.extent)

//let nsImage = NSImage(cgImage: outputImageUncropped, size: outputImageUncropped.extent.size)



/*:
 [CoreImage Reference](https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html)
 */

/*:
 ----
 ## References?
 
 https://github.com/Luubra/EmojiIntelligence
 
 https://github.com/stephencelis/SQLite.swift
 
 https://github.com/Carthage/Carthage#installing-carthage
 
 https://gist.github.com/kristopherjohnson/4201fbe86473f6edb207
 
 http://nshipster.com/benchmarking/
 
 http://alexsosn.github.io/ml/2015/11/19/metal_gpgpu.html
 
 
  */
