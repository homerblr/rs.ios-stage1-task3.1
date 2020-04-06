#import "Combinator.h"

@implementation Combinator

unsigned long long factorial( unsigned int j )
{
    unsigned long long factorial = 1;

    for (unsigned int i = 2; i <= j; i++ ) factorial *= i;

    return factorial;
}

- (unsigned int)binomWithN:(unsigned int)n adnK:(unsigned int)k {


    return factorial(n)/factorial(k)/factorial(n-k);
}

- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    if (![array count]) {
        return nil;
    }
    for (NSNumber *number in array) {
        if (![number isKindOfClass:[NSNumber class]]) {
            return nil;
        }
    }
    unsigned int n = [array[1] unsignedIntValue];
    unsigned int x = [array[0] unsignedIntValue];
    unsigned int res;
    for (unsigned int k = 1; k < n;k++) {
         res = [self binomWithN:n adnK:k];
        if (res == x){
            return [NSNumber numberWithInt:k];
        }
    }
    return  nil;
}

@end
