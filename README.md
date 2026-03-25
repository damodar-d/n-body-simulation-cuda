# Physics based N-Body simulation in CUDA

This program is all about simulating mututal interactions between N-particle system governed by __*Newton's law of Universal Gravitation*__

$$
F_{i_{j}} = \sum_{i,j}^{n} G \cdot (m_i m_j) \cdot \frac {r_i} {| r_{i_{j}} |^3}
$$

## Before trying out
Before trying it out locally on your system, make sure that your system is equipped with Nvidia GPU and has stable version of CUDA installed.

To verify whether or not your system has CUDA installed, type ```nvcc --version```

Failing to verify above will result in execution on the program only to CPU.


## How to Use
```make``` Compiles into executable.

```make run``` Runs the executables.