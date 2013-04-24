#import "NSInvocation+Cedar.h"
#import <objc/runtime.h>

@implementation NSInvocation (Cedar)

- (void)retainMethodArgumentsAndCopyBlocks {
    NSMethodSignature *methodSignature = [self methodSignature];
    NSUInteger numberOfArguments = [methodSignature numberOfArguments];
    NSMutableArray *retainedArguments = [NSMutableArray arrayWithCapacity:numberOfArguments];

    for (NSUInteger argumentIndex = 2; argumentIndex < numberOfArguments; ++ argumentIndex) {
        const char *encoding = [methodSignature getArgumentTypeAtIndex:argumentIndex];
        id argument = nil;
        [self getArgument:&argument atIndex:argumentIndex];
        if (strlen(encoding) == 2 && strncasecmp("@?", encoding, 2) == 0) {
            argument = [argument copy];
            [retainedArguments addObject:argument];
            [argument release];
            [self setArgument:&argument atIndex:argumentIndex];
        } else if (encoding[0] == '@') {
            if (argument) {
                [retainedArguments addObject:argument];
            }
        }
    }

    objc_setAssociatedObject(self, @"retained-arguments", retainedArguments, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
