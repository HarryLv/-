//
//  UIFont+Extension.m

#import "UIFont+Extension.h"

@implementation UIFont (Extension)
+ (UIFont *)customFontOfSize:(CGFloat)fontSize{
    //1.193359375f
//    UIFont *font = [UIFont systemFontOfSize:lineHeight/1.19f];
    
    CGFloat fontScale = [self fontScale];
    UIFont *font = [UIFont systemFontOfSize:fontSize / fontScale];
    return font;
}

+ (UIFont *)blodCustomFontOfSize:(CGFloat)fontSize{
    
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize * SCSCALE];
    return font;
}

+ (CGFloat)fontScale{
    CGFloat fontScale = 1080.f / SCREEN_WIDTH;
    if (SCREEN_WIDTH == 320.f) {
        fontScale = floorf(fontScale);
    }
    return fontScale;
}
@end
