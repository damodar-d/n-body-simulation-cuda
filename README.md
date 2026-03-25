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


## Comparison

|N  | CPU Execution Time | GPU Execution Time |
| :---         |     :---:      |          ---: |
1000	| 0.0060	| 0.920| 
5000	| 0.1000	| 0.100| 
10000	| 0.0430	| 0.097| 
20000	| 0.1630	| 0.340| 
30000	| 0.3840	| 0.123| 
40000	| 0.6530	| 0.100| 
45000	| 0.8500	| 0.111| 
50000	| 1.0280	| 0.103| 
65000	| 1.7460	| 0.113| 
80000	| 2.6350	| 0.123| 
90000	| 3.3280	| 0.135| 
100000	| 4.0970	| 0.131| 
200000	| 16.5490	| 0.230| 
250000	| 26.4500	| 0.301| 
500000	| 106.4080	| 0.870| 
1000000	| 446.1000	| 3.105| 


![CPU vs GPU comparison](/assets//cpu-vs-gpu%20comparison%20n-body%20simulation.png)
