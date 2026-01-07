
// C Reference 
#define RCC_APB2ENR   (*(volatile unsigned int *)0x40021018)
#define GPIOA_CRL     (*(volatile unsigned int *)0x40010800)
#define GPIOA_BSRR    (*(volatile unsigned int *)0x40010810)

void delay(void)
{
    for (volatile unsigned int i = 0; i < 100000; i++);
}

int main(void)
{
    /* Enable GPIOA clock (bit 2) */
    RCC_APB2ENR |= (1 << 2);

    /* PA5 output push-pull, 2 MHz */
    GPIOA_CRL &= ~(0xF << 20);
    GPIOA_CRL |=  (0x2 << 20);

    while (1)
    {
        /* LED ON */
        GPIOA_BSRR = (1 << 5);
        delay();

        /* LED OFF */
        GPIOA_BSRR = (1 << 21);
        delay();
    }
}
