#include <stdio.h>
#include <cuda_runtime.h>
#include <cuda.h>
#include <time.h>
#include "kernel.cuh"
#include "include/constants.h"
#include "cpu_simulation.cuh"




void run_simulation_gpu(int N, float dt)
{

    size_t size = N * sizeof(float);

    // 1. Allocate memory on RAM

    float *h_posX = new float[N];
    float *h_posY = new float[N];
    float *h_posZ = new float[N];

    float *h_velX = new float[N];
    float *h_velY = new float[N];
    float *h_velZ = new float[N];

    float *h_mass = new float[N];

    for (int i = 0; i < N; i++)
    {
        h_posX[i] = rand() / (float)RAND_MAX;
        h_posY[i] = rand() / (float)RAND_MAX;
        h_posZ[i] = rand() / (float)RAND_MAX;

        h_velX[i] = 0.0f;
        h_velY[i] = 0.0f;
        h_velZ[i] = 0.0f;

        h_mass[i] = 1.0f;
    }

    // 2. Allocate memory on GPU

    float *d_posX;
    float *d_posY;
    float *d_posZ;

    float *d_velX;
    float *d_velY;
    float *d_velZ;

    float *d_mass;

    cudaMalloc(&d_posX, size);
    cudaMalloc(&d_posY, size);
    cudaMalloc(&d_posZ, size);

    cudaMalloc(&d_velX, size);
    cudaMalloc(&d_velY, size);
    cudaMalloc(&d_velZ, size);

    cudaMalloc(&d_mass, size);

    // Copying Positional data
    cudaMemcpy(d_posX, h_posX, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_posY, h_posY, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_posZ, h_posZ, size, cudaMemcpyHostToDevice);

    // Copying Velocity data
    cudaMemcpy(d_velX, h_velX, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_velY, h_velY, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_velZ, h_velZ, size, cudaMemcpyHostToDevice);

    // Copying Mass data
    cudaMemcpy(d_mass, h_mass, size, cudaMemcpyHostToDevice);

    // Kernel Launching configuration
    int threads_per_block = 256;

    // Each thread handles one particle
    // Total threads = numBlocks × blockSize

    int number_of_blocks = (N + threads_per_block - 1) / threads_per_block;

    simulate<<<number_of_blocks, threads_per_block>>>(
        d_posX, d_posY, d_posZ,
        d_velX, d_velY, d_velZ,
        N,
        d_mass,
        dt);

    cudaMemcpy(h_velX, d_velX, size, cudaMemcpyDeviceToHost);
    cudaMemcpy(h_velY, d_velY, size, cudaMemcpyDeviceToHost);
    cudaMemcpy(h_velZ, d_velZ, size, cudaMemcpyDeviceToHost);

    delete[] h_posX, delete[] h_posY, delete[] h_posZ,
        delete[] h_velX, delete[] h_velY, delete[] h_velZ,
        delete[] h_mass;

    cudaFree(d_posX);
    cudaFree(d_posY);
    cudaFree(d_posZ);
    cudaFree(d_velX);
    cudaFree(d_velY);
    cudaFree(d_velZ);
    cudaFree(d_mass);
}

int main()
{
    int N = 100000;

    clock_t start, end;
    start = clock();

    printf("Particle Count: %d\n", N);

    // printf("Mode of Execution:GPU\n");
    // run_simulation_gpu(N,0.01);
    // cudaDeviceSynchronize();

    printf("Mode of Execution:CPU\n");
    run_simulation_cpu(N,0.01);

    end = clock();

    printf("Time taken: %f seconds", ((double)end - start) / CLOCKS_PER_SEC);

    return 0;
}