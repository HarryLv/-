
#import "NSDictionary+JsonDict.h"

@implementation NSDictionary (JsonDict)

-(NSString*) strForKey: (NSString*) key
{
    id val = [self objectForKey: key ];
	if ( [val isKindOfClass: [NSString class]] ){
		return val;
	}else if ( [val isKindOfClass: [NSNumber class]] ) {
        return [(NSNumber *)val stringValue];
    }
    return @"";
}

-(int) intForKey: (NSString*) key
{
    id val = [self objectForKey: key ];
	if ( [val isKindOfClass: [NSNumber class]] ){
		return [val intValue];
	}else if ( [val isKindOfClass: [NSString class]] ) {
        return [val intValue];
    }
    return 0;
}

-(float) floatForKey: (NSString*) key
{
    id val = [self objectForKey: key ];
	if ( [val isKindOfClass: [NSNumber class]] ){
		return [val floatValue];
	}else if ( [val isKindOfClass: [NSString class]] ) {
        return [val floatValue];
    }
    return 0.0f;
}

-(long long) longlongForKey: (NSString*) key
{
    id val = [self objectForKey: key ];
	if ( [val isKindOfClass: [NSNumber class]] ){
		return [val longLongValue];
	}else if ( [val isKindOfClass: [NSString class]] ) {
        return [val longLongValue];
    }
    return 0;
}
@end
