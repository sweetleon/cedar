#import "AnyInstanceArgument.h"

namespace Cedar { namespace Doubles {

    AnyInstanceArgument::AnyInstanceArgument(Class klass) : Argument(), class_(klass) {}
    AnyInstanceArgument::~AnyInstanceArgument() {}

    /*virtual*/ const char * const AnyInstanceArgument::value_encoding() const {
        return @encode(Class);
    }

    /*virtual*/ void * AnyInstanceArgument::value_bytes() const {
        return NULL;
    }

    /*virtual*/ NSString * AnyInstanceArgument::value_string() const {
        return [NSString stringWithFormat:@"Any instance of %@", NSStringFromClass(class_)];
    }

    /*virtual*/ size_t AnyInstanceArgument::value_size() const {
        return sizeof(Class);
    }

    /*virtual*/ bool AnyInstanceArgument::matches_encoding(const char * actual_argument_encoding) const {
        return 0 == strncmp("@", actual_argument_encoding, 1);
    }

    /*virtual*/ bool AnyInstanceArgument::matches_bytes(void * actual_argument_bytes) const {
        return [*(static_cast<NSObject **>(actual_argument_bytes)) isKindOfClass:class_];
    }

    namespace Arguments {
        Argument::shared_ptr_t any(Class klass) {
            return Argument::shared_ptr_t(new AnyInstanceArgument(klass));
        }
    }

}}
