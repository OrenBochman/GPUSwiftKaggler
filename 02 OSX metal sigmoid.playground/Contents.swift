import PlaygroundSupport
import Cocoa
import Metal

/*:
 ----
 ![](badge_1.png)
 
 ## Using Metal on IOS and OSX : Introduction to Compute Programming
 
 *[Shlomo Kashani](shlomokashani@gmail.com), July 2017*
 
 *July 2017: [Created for Swift 3.1 / Xcode 9.1 Beta](https://github.com/QuantScientist)*

 
 Since Metal does not run in the **Xcode simulator** and since we cannot assume all our readers have an iOS device that has an A7 processor or newer, we will rather create an **OS X project** instead.
 
 The easiest way to test for Metal support is to check the return of MTLCreateSystemDefaultDevice().The function **MTLCopyAllDevices()** returns all the GPUs the system has. This function is only available on **OS X**. On iOS, there is only one device, and you get it by calling **MTLCreateSystemDefaultDevice()**.
 */
let devices=MTLCopyAllDevices()
for d in devices {
    print("Device: \(d)")
}

let defaultDevice=MTLCreateSystemDefaultDevice()
print("Default device: \(defaultDevice!)")

/*:
  ----
 - Experiment:
 An external script can verify this on your machine.
 
 **curl** -o ~/Desktop/metaltest.swift https://raw.githubusercontent.com/goalque/automate-eGPU/master/metaltest.swift
 **cd** ~/Desktop
 **swiftc** -sdk $(xcrun --show-sdk-path) -target x86_64-apple-macosx10.11 -o metaltest metaltest.swift
 **./metaltest**
 */

/*: 
  ----
 ## IOS Memory Model
 A notable feature on iOS is that one can **share memory between GPU and CPU** (less copying of data). iPhones/iPod Touches/iPads all have a Unified Memory Architecture which mean that both the CPU and GPU share system memory. There is no dedicated video memory on these devices.
 */
let device = require(MTLCopyAllDevices().first{ $0.isLowPower } ?? MTLCreateSystemDefaultDevice(),
                     orDie: "No Metal device available on this Machine")
//: On my MacBook it is: Intel HD Graphics 4000 low power

let commandQueue = device.makeCommandQueue()
let drawingQueue = DispatchQueue(label: "drawingQueue", qos: .userInteractive)


let shaderSource = require(try String(contentsOf: #fileLiteral(resourceName: "Shaders.metal")), orDie: "unable to read shader source file")
let library = require(try device.makeLibrary(source: shaderSource, options: nil),orDie: "compiling shaders failed")
let sigmoidShader = require(library.makeFunction(name:"sigmoidShader"),orDie: "unable to get sigmoidShader")

let sigmoidtPipelineState = require(try device.makeComputePipelineState(function: sigmoidShader),orDie: "unable to create compute pipeline state")

let v=myVector(len:10)
print (v)

// https://medium.com/@atveit/example-of-swift-and-metal-gpu-programming-on-osx-10-11-el-capitan-a8cf75bd1b43

//let metal = executionTimeInterval {
//    _ = device.metalComputeFuncton("sigmoidShader", param: v)
//}
//print(metal)

/*:
 ----
 ### Drawing
 
 */

