#include <stdio.h>

unsigned long long fact_aux(unsigned long long n, unsigned long long i, unsigned long long acc) {
    if (i < n) {
        return fact_aux(n, i + 1, acc * i);
    } else{
        return acc * n; 
    }
};

unsigned long long factorial (unsigned long long n) {
    if (n > 0){
        return fact_aux(n, 1, 1);
    } else {
        return 1;
    }
}

unsigned long long fact_dec_aux(unsigned long long n, unsigned long long k, unsigned long long i, unsigned long long acc) {
    if (i == k) {
        return acc;
    }
    return fact_dec_aux(n - 1, k, i + 1, acc * (n - 1));
}

unsigned long long fact_dec(unsigned long long n, unsigned long long k) {
    if (k == 0) return 1; 
    if (k > n) return 0; 
    return fact_dec_aux(n, k, 1, n);
}

unsigned long long cnk (unsigned long long n, unsigned long long k){
    return fact_dec(n, k) / factorial(k);
}

unsigned long long narayana (unsigned long long n, unsigned long long k){
    return (cnk(n, k) * cnk (n, k - 1)) / n;
}

unsigned long long trib_aux (unsigned long long n, unsigned long long i, unsigned long long f1, unsigned long long f2, unsigned long long f3){
    if ( i == n ){
        return f3;
    } else {
        return trib_aux(n, i + 1, f2, f3, f1 + f2 + f3);
    }
}

unsigned long long trib(int n){
    if (n == 0 || n == 1 || n == 2) {
        return n;
    }
    return trib_aux(n, 2, 0, 1, 2);
}

unsigned long long floorlog2 (unsigned long long n) {
    int i = 0;
    while (n > 1){
        n = n / 2; i++;
    }
    return i;
}

unsigned long long maldad (unsigned long long n) {
    return trib(floorlog2(narayana(n, floorlog2(n))) + 1);
}

int main() {

    int flag = 1;
    int input;

    while (flag){
        printf("Please, input a number for EVIL or type 0 to exit the program: \n> ");
        int status = scanf("%d", &input);
        if (status != 1) {
            printf("Not VALID input. Try only numbers\n");
            while (getchar() != '\n'); 
            continue;
        }
        if (input != 0){
            if (input > 0 && input <= 100){
                unsigned long long int result = maldad(input);
                printf("This is EVIL: %llu\n", result);
            } else if (input > 100){
                printf("Too EVIL. Try a smaller number\n");
            } else if (input < 0) {
                printf("Not EVIL at all. Try only positive numbers\n");
            } else {
                printf("Not VALID input. Try only numbers\n");
            }
        } else {
            flag = 0;
        }
    }

    return 0;
}
