#include "kernel.cuh"


__global__ void simulate(
    float *px, float *py, float *pz,
    float *vx, float *vy, float *vz,
    int N,
    float *body_mass,
    float dt)
{

    int i = threadIdx.x + blockDim.x * blockIdx.x;

    if (i >= N)
        return;

    float force_x = 0.0f; // This value is per-thread
    float force_y = 0.0f; // This value is per-thread
    float force_z = 0.0f; // This value is per-thread

    // For a certain particle i, we are calculating :

    for (int j = 0; j < N; j++)
    {

        if (i == j)
            continue;

        // 1. Distance in all directions between that particle and every other particle
        float dx = px[j] - px[i];
        float dy = py[j] - py[i];
        float dz = pz[j] - pz[i];

        // Squared distance
        float squared_distance = dx * dx + dy * dy + dz * dz;
        float reciprocal_sqrt = rsqrt(squared_distance);
        float dist3 = reciprocal_sqrt * reciprocal_sqrt * reciprocal_sqrt;

        float force_overall = body_mass[j] * dist3;

        force_x += force_overall * dx;
        force_y += force_overall * dy;
        force_z += force_overall * dz;
    }

    vx[i] += force_x * dt;
    vy[i] += force_y * dt;
    vz[i] += force_z * dt;
}