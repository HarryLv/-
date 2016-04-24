

#import <Foundation/Foundation.h>

/**
  *  NSDictionary+JsonDict 类别
 */
@interface NSDictionary (JsonDict)

/**
	返回字典中Key对应的Value值。
	@returns Value为string类型，则返回NSString类型。如果Value
            不为string类型则返回@""。
 */
-(NSString*) strForKey: (NSString*) key;
/**
	返回字典中Key对应的Value值。
	@returns value为NSNumber或NSString类型，则调用intValue()返
             回int值。否则返回0。
 */
-(int) intForKey: (NSString*) key;
/**
	返回字典中Key对应的Value值。
	@returns value为NSNumber或NSString类型，则调用floatValue()返
             回float值。否则返回0.0。
 */
-(float) floatForKey :(NSString*) key;
-(long long) longlongForKey: (NSString*) key;

@end

