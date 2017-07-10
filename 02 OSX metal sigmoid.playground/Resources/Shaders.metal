#include <metal_stdlib>
using namespace metal;

#define M_PI 3.141592653589793238462643383

constant int THREADGROUP_SIZE = 256;


kernel void sigmoidShader(const device float *inVector [[ buffer(0) ]],
                    device float *outVector [[ buffer(1) ]],
                    uint id [[ thread_position_in_grid ]]) {
    outVector[id] = 1.0 / (1.0 + exp(-inVector[id]));
}

kernel void doubler(const device float *inVector [[ buffer(0) ]],
                    device float *outVector [[ buffer(1) ]],
                    uint id [[ thread_position_in_grid ]]) {
    outVector[id] = 2*inVector[id];
}
