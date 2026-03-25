__global__ void simulate(
    float *px, float *py, float *pz,
    float *vx, float *vy, float *vz,
    int N,
    float *body_mass,
    float dt);