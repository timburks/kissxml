#import "NSStringAdditions.h"


@implementation NSString (NSStringAdditions)

- (const xmlChar *)xmlChar
{
	return (const xmlChar *)[self UTF8String];
}

- (NSString *)trimWhitespace
{
	NSMutableString *mStr = [self mutableCopy];
#ifdef DARWIN
	CFStringTrimWhitespace((CFMutableStringRef)mStr);
#endif
	
	NSString *result = [mStr copy];
	
	[mStr release];
	return [result autorelease];
}

@end
