#import "Argument.h"

namespace Cedar { namespace Doubles {

    class AnyInstanceArgument : public Argument {
    private:
        AnyInstanceArgument(const AnyInstanceArgument &);
        AnyInstanceArgument & operator=(const AnyInstanceArgument &);

    public:
        explicit AnyInstanceArgument(Class klass);
        virtual ~AnyInstanceArgument();

        virtual const char * const value_encoding() const;
        virtual void * value_bytes() const;
        virtual NSString * value_string() const;
        virtual size_t value_size() const;

        virtual bool matches_encoding(const char * actual_argument_encoding) const;
        virtual bool matches_bytes(void * actual_argument_bytes) const;

    private:
        Class class_;
    };

    namespace Arguments {
        Argument::shared_ptr_t any(Class klass);
    }

}}
