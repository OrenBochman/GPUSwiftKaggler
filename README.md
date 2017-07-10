<img src="https://github.com/QuantScientist/GPUSwiftKaggler/blob/master/swiftkaggler.png" width="300">

# A Swift/Metal based library for IOS/OSX GPU based Machine and Deep Learning for Kaggle.
![Swift 3.0 compatible](https://img.shields.io/badge/Swift-3.0-orange.svg)

## Introduction

**GPUSwiftKaggler** contains Apple playgrounds and full Xcode projects for running compute kernels on an apple GPU instance targeting mostly *Kaggle competitions*. Many frameworks have been incorporated into this (Metal, MPSCNN, Metal Performance Shaders, HDF5Kit, ) to make it easier to get you going.

**AFAIK, GPUSwiftKaggler is the first Swift based library for Kaggle.** 

## Features
- [x] Very fast: uses Metal and Accelerate under the hood. 
- [x] Extensible image processing for feature generation.
- [x] TBD
- [x] TBD
- [x] TBD
- [x] TBD

## Motivation 
**Dreaming about writing an ML based app for the iPhone?** Want to get your hands dirty in a Kaggle competition? Want to use the GPU with Metal? 
You are in the right place. 

## Bakcground 
**Apple's Metal** is a low-level, low-overhead hardware-accelerated graphics API that debuted in iOS 8. Apple states that Metal "lets developers create highly immersive console-style games on iPhone. Metal is optimized to allow the CPU and GPU to work together to deliver detailed graphics and complex visual eﬀects." 

![](metal.jpeg)

Apple had also recently presented a native machine learning (**CoreML**) and machine vision (**Vision**) frameworks augmenting the already existing libraries they provided (e.g, Accelerate). This significantly enhances the vast array of ML based apps that can be deployed to IOS based devices.

![](playground.png)

## Requirements
*Note: To use this library you need Xcode 8 and an iOS 10-compatible device (or latest Mac OSX) with at least an A8 processor.*
Stack:

• The GPU

• CoreML

• Accelerate

• MPSCNN

• Metal Performance Shaders

• CNN

• Metal

• Swift

• iOS 11.0 Beta

• Xcode 9+ Beta


## Usage

This example shows how to use an existing Kaggle Data set.

```swift
import HDF5Kit
import Metal 
import Accelerate
import GPUSwiftKaggler

```


## Maintainer

Shlomo Kashani ([shlomo@deep-ml.com](http://deep-ml.com))


## Credits

https://github.com/aleph7/HDF5Kit

https://github.com/evgenyneu/SigmaSwiftStatistics

https://github.com/mattt/Surge


