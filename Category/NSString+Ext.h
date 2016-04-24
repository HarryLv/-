
#import <Foundation/Foundation.h>

@interface NSString (Ext)


+ (NSString*) md5HexDigest:(NSString*) str;
+ (NSString*) md5HexForFile: (NSString*) filePath;
+ (NSString*) md5HexForData: (NSData*) data;

-(BOOL) isNotEmpty;

+(bool) isStringEmpty:(NSString*) string;

+(bool) isString:(NSString*) s1 sameTo:(NSString*)s2;

+ (NSString *)getDurationString:(int) duration;

@end
