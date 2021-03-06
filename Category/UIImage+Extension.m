//
//  UIImage+Extension.m

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

#pragma mark - 生成圆角带边框的图片（正方形图片）
+ (instancetype)roundImageWithOriginalImage:(UIImage *)originalImage size:(CGSize)targetSize borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    return [originalImage roundImageWithSize:targetSize borderWidth:borderWidth borderColor:borderColor];
}

- (UIImage *)roundImageWithSize:(CGSize)targetSize borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 1.加载原图
    UIImage *oldImage = self;
    
    // 2.开启上下文
    CGFloat imageW ;
    CGFloat imageH ;
    
    imageW = targetSize.width;
    imageH = targetSize.height;
    
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);//0.f 默认是屏幕scale
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW / 2.f; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, (imageW - borderWidth * 2.f), (imageH - borderWidth * 2.f))];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 生成圆角图片
- (UIImage *)roundImage{
    return [self roundImageWithSize:CGSizeZero];
}

- (UIImage *)roundImageWithSize:(CGSize)targetSize{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageW ;
    CGFloat imageH ;
    
    if (CGSizeEqualToSize(targetSize, CGSizeZero)) {
        targetSize = self.size;
        scale = self.scale;
    }
    
    imageW = targetSize.width;
    imageH = targetSize.height;
    
    CGRect frame = CGRectMake(0, 0, imageW , imageH);
    CGFloat cornerRadius = MIN(imageW, imageH)/2.f;
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, scale);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius] addClip];
    // Draw your image
    [self drawInRect:frame];
    // Retrieve and return the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 修改图片尺寸
- (UIImage *)scalingToSize:(CGSize)targetSize {
    return [self scalingToSize:targetSize withScale:NO];
}

- (UIImage *)scalingToSize:(CGSize)targetSize withScale:(BOOL)withScale{
    UIImage *sourceImage = self;
    CGFloat scale = withScale ? [UIScreen mainScreen].scale : 1.f;  //0.f 默认是屏幕scale
    UIGraphicsBeginImageContextWithOptions(targetSize,NO,scale);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

#pragma mark - 剪切出最适合Size的图片
- (UIImage *)resizableImageFitToSize:(CGSize) toSize{
    CGFloat toScale = toSize.height / toSize.width;
    CGFloat originalScale = self.size.height / self.size.width;
    
    CGFloat width ;
    CGFloat height;
    if (toScale > originalScale) {
        height = self.size.height;
        width = height / toScale;
    }else{
        width = self.size.width;
        height = width * toScale;
    }
    
    CGFloat x = (self.size.width - width) / 2.f;
    CGFloat y = (self.size.height - height) / 2.f;
    
    CGImageRef tempImgRef = self.CGImage;
    CGImageRef imgRef = CGImageCreateWithImageInRect(tempImgRef, CGRectMake(x * self.scale, y* self.scale, width* self.scale, height* self.scale));
    UIImage *resoultImg = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return resoultImg;
}

#pragma mark - 生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, ceilf(size.width), ceilf(size.height));
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)roundImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, ceilf(size.width), ceilf(size.height));
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 生成一个带文字的圆形图片
+ (UIImage *)imageWithBackgroundColor:(UIColor *)bgColor textColor:(UIColor *)textColor text:(NSString *)text rect:(CGRect)rect textFont:(UIFont *)textFont
{
    CGFloat rectH = rect.size.height;
    CGFloat rectW = rect.size.width;
    
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画圆
    CGContextSetFillColorWithColor(context, [bgColor CGColor]);
    CGContextFillEllipseInRect(context, rect);
    //画字
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)//限制最大的宽度和高度
                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                   attributes:@{NSFontAttributeName: textFont}
                                      context:nil];
    CGRect drawTextRect = CGRectMake((rectW - textRect.size.width)/2 , (rectH -textRect.size.height)/2, rectW, rectH);
    [text drawInRect:drawTextRect withAttributes:@{NSFontAttributeName: textFont,
                                           NSForegroundColorAttributeName:textColor}];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 图片拉伸
+(UIImage*)resizedImageWithName:(NSString *)name{
    UIImage* image = [UIImage imageNamed:name];
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
//    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    
        return [image stretchableImageWithLeftCapWidth:w topCapHeight:h];
}

+(UIImage*)resizedImageWithName:(NSString *)name location:(CGPoint)location{
    UIImage* image = [UIImage imageNamed:name];
    CGFloat w = image.size.width * location.x;
    CGFloat h = image.size.height * location.y;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, image.size.width - h, image.size.width - w)];
    
    //    return [image stretchableImageWithLeftCapWidth:w topCapHeight:h];
}
@end
