#import <Cedar/SpecHelper.h>
#import "Argument.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ArgumentSpec)

__block NSArray<CedarDouble> *array;

beforeEach(^{
    array = nice_fake_for([NSArray class]);
});

describe(@"Arguments::anything", ^{
    it(@"should match non-objects", ^{
        [array objectAtIndex:7];
        array should have_received("objectAtIndex:").with(Arguments::anything);
    });

    it(@"should match objects", ^{
        [array containsObject:[NSString string]];
        array should have_received("containsObject:").with(Arguments::anything);
    });
});

describe(@"Arguments::any(class)", ^{
    it(@"should match any instance of the specified class", ^{
        [array containsObject:[NSString string]];

        array should have_received("containsObject:").with(Arguments::any([NSString class]));
    });

    it(@"should not match an instance of another class", ^{
        [array containsObject:[NSString string]];

        array should_not have_received("containsObject:").with(Arguments::any([NSArray class]));
    });

    it(@"should (not?) match a subclass of the specified class", PENDING);
});

SPEC_END
