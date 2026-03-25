void run_simulation_cpu(int N, float dt)
{

    float* posx = new float[N];
    float* posy = new float[N];
    float* posz = new float[N];

    float* velx = new float[N];
    float* vely = new float[N];
    float* velz = new float[N];

    float* mass = new float[N];

    for (int i = 0; i < N; i++)
    {
        posx[i] = rand() / (float)RAND_MAX;
        posy[i] = rand() / (float)RAND_MAX;
        posz[i] = rand() / (float)RAND_MAX;

        velx[i] = 0.0f;
        vely[i] = 0.0f;
        velz[i] = 0.0f;

        mass[i] = 1.0f;
    }

    for (int i = 0; i < N; i++)
    {

        float force_x = 0.0f;
        float force_y = 0.0f;
        float force_z = 0.0f;

        for (int j = i+1 ; j < N; j++)
        {

            float dx = posx[j] - posx[i];
            float dy = posy[j] - posy[i];
            float dz = posz[j] - posz[i];

            float squared_dist = dx * dx + dy * dy + dz * dz;
            float reciprocal_sqrt = rsqrt(squared_dist);
            float dist3 = reciprocal_sqrt * reciprocal_sqrt * reciprocal_sqrt;

            float force_j_overall = mass[j] * dist3;

            force_x = force_j_overall * dx;
            force_y = force_j_overall * dy;
            force_z = force_j_overall * dz;
        }
        velx[i]+= force_x * dt;
        vely[i]+= force_y * dt;
        velz[i]+= force_z * dt;
    }
}