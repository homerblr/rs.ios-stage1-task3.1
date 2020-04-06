#import "PolynomialConverter.h"

@implementation PolynomialConverter


- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    if (![numbers count]) {
        return nil;
    }

    NSMutableArray *mutableNumbers = [numbers mutableCopy];
    NSMutableString *xWithExponent = [NSMutableString string];
    
    for (int i = 0; i < [mutableNumbers count]; i++) {
        if ([mutableNumbers[i] isKindOfClass:[NSNumber class]]) {
            unsigned long maxExponent = [mutableNumbers count] - 1;
            char *plusOrMinus =  [mutableNumbers[i] intValue] > 0 ? (i == 0 ? "" : " + ") : (i == 0 ? "-" : " - ");
            int coefficient = abs([mutableNumbers[i] intValue]);
            unsigned long exponent = maxExponent - i;
                switch (exponent) {
                    case 0:
                        if(coefficient == 0){
                        [xWithExponent appendString:@""];
                        }else
                        [xWithExponent appendFormat:@"%s%d",plusOrMinus, coefficient];
                        break;
                    case 1:
                        if(coefficient == 0){
                        [xWithExponent appendString:@""];
                        }else
                        if (coefficient == 1) {
                        [xWithExponent appendFormat:@"%sx",plusOrMinus];
                        }else
                        [xWithExponent appendFormat:@"%s%dx",plusOrMinus, coefficient];
                        break;
                    default:
                        if(coefficient == 0){
                        [xWithExponent appendString:@""];
                        }else
                        [xWithExponent appendFormat:@"%s%dx^%lu",plusOrMinus, coefficient, exponent];
                        break;
                }
        }
}
    return [NSString stringWithString: xWithExponent];
}

@end
