#include <dos.h>

int int86(int intno, union REGS *inregs, union REGS *outregs);

int mi_getchar()
{
    union REGS inregs, outregs;
    int caracter;

    inregs.h.ah = 1;
    int86(0x21, &inregs, &outregs);

    caracter = outregs.h.al;
    return caracter;
}

int mi_putchar(char c)
{
    union REGS inregs, outregs;

    inregs.h.ah = 2;
    inregs.h.dl = c;
    int86(0x21, &inregs, &outregs);
}

int main()
{
    int tmp, i;
    for (i = 0; i < 5; i++)
    {
        printf("\nPulsa cualquier tecla: ");
        tmp = mi_getchar();
        printf("\nLa tecla que acabas de pulsar es: ");
        mi_putchar(tmp);
    }
    return 0;
}
