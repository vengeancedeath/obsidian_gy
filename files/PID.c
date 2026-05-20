typedef struct
{
    // PID 三参数
    float Kp;
    float Ki;
    float Kd;

    // 控制变量
    float target;    // 目标值
    float curr_val;  // 实际反馈值
    float err;       // 当前误差
    float err_last;  // 上一次误差
    float integral;  // 积分累计
    float time;  // 时间间隔

    // 限幅（防止炸机、积分饱和）
    float out_min;   // 输出下限
    float out_max;   // 输出上限
    float int_max;   // 积分限幅
} PID_t;

// PID 初始化
void PID_Init(PID_t *pid, float kp, float ki, float kd, 
              float out_min, float out_max, float int_max, float time)
{
    pid->Kp = kp;
    pid->Ki = ki;
    pid->Kd = kd;
    pid->out_min = out_min;
    pid->out_max = out_max;
    pid->int_max = int_max;
    pid->time = time;

    pid->target = 0;
    pid->curr_val = 0;
    pid->err = 0;
    pid->err_last = 0;
    pid->integral = 0;
}

// 位置式PID计算
float PID_Pos_Calc(PID_t *pid, float target, float curr)
{
    // 1. 更新目标与反馈
    pid->target = target;
    pid->curr_val = curr;

    // 2. 计算当前误差
    pid->err = pid->target - pid->curr_val;

    // 3. 积分累加 + 积分限幅
    pid->integral += pid->err * pid->time;
    if(pid->integral >  pid->int_max) pid->integral =  pid->int_max;
    if(pid->integral < -pid->int_max) pid->integral = -pid->int_max;

    // 4. PID 核心公式
    float p = pid->Kp * pid->err;
    float i = pid->Ki * pid->integral;
    float d = pid->Kd * (pid->err - pid->err_last)/pid->time;

    float out = p + i + d;

    // 5. 输出限幅
    if(out > pid->out_max) out = pid->out_max;
    if(out < pid->out_min) out = pid->out_min;

    // 6. 更新上一次误差
    pid->err_last = pid->err;

    return out;
}