//
//  UIImage+Extension.h

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  把图片裁剪成带边框的圆形图片
 *
 *  @param originalImage   原图片
 *  @param targetSize   目标大小
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 *
 *  @return 圆形有边框的图片
 */
+ (instancetype)roundImageWithOriginalImage:(UIImage *)originalImage size:(CGSize)targetSize borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (UIImage *)roundImageWithSize:(CGSize)targetSize borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//生成圆角图片
- (UIImage *)roundImage;
- (UIImage *)roundImageWithSize:(CGSize)targetSize;

//修改图片尺寸
- (UIImage *)scalingToSize:(CGSize)targetSize;
- (UIImage *)scalingToSize:(CGSize)targetSize withScale:(BOOL)withScale;

//按宽高比切出合适image
- (UIImage *)resizableImageFitToSize:(CGSize) toSize;

//生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)roundImageWithColor:(UIColor *)color size:(CGSize)size;

//圆形纯色图片中间带一个字
+ (UIImage *)imageWithBackgroundColor:(UIColor *)bgColor textColor:(UIColor *)textColor text:(NSString *)text rect:(CGRect)rect textFont:(UIFont *)textFont;

//图片拉伸
+(UIImage*)resizedImageWithName:(NSString *)name;
+(UIImage*)resizedImageWithName:(NSString *)name location:(CGPoint)location;
@end
