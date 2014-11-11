//
//  STShineLabel.m
//  ShineText
//
//  Created by QinMingChuan on 14/11/11.
//  Copyright (c) 2014年 413132340@qq.com. All rights reserved.
//

#import "STShineLabel.h"


@interface STShineLabel()
@end

@implementation STShineLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _starPoint  = CGPointMake(0, 0);
        _endPoint   = CGPointMake(1, 1);
    }
    
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if(text) //有/并且后面有内容
    {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
        NSRange range = NSMakeRange(0, text.length);
        
        //光晕
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 3;
        shadow.shadowColor = [UIColor greenColor];
        [attString addAttribute:NSShadowAttributeName value:shadow range:range];
        
        //行列布局
        NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        ps.lineSpacing      = 3;    //行距
//        ps.paragraphSpacing = 26;    //段距
//        ps.headIndent       = -26;   //行头锁进
        [attString addAttribute:NSParagraphStyleAttributeName value:ps range:range];
        self.attributedText = attString;
    }
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGradientInContext:context withRect:rect];
    CGContextRestoreGState(context);
}

- (void)drawGradientInContext:(CGContextRef)context withRect:(CGRect)rect
{
    NSArray *gradientColors = @[[UIColor darkGrayColor],self.textColor, [UIColor greenColor], [UIColor redColor], self.textColor];
    
    UIColor *highlightedColor = self.highlightedTextColor ?: self.textColor;
    UIColor *textColor = self.highlighted? highlightedColor: self.textColor;
    textColor = textColor ?: [UIColor clearColor];
    
    CGImageRef alphaMask = NULL;
    // Create an image mask from what we've drawn so far
    alphaMask = CGBitmapContextCreateImage(context);
    //clear the context
    CGContextClearRect(context, rect);
    
    //clip the context
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, alphaMask);
    
    //create array of pre-blended CGColors
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:[gradientColors count]];
    for (UIColor *color in gradientColors)
    {
        UIColor *blended = [self color:color.CGColor blendedWithColor:textColor.CGColor];
        [colors addObject:( id)blended.CGColor];
    }
    
    CGRect textRect = rect;
    //draw gradient
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    CGGradientRef gradient = CGGradientCreateWithColors(NULL, (__bridge  CFArrayRef)colors, NULL);
    CGPoint startPoint = CGPointMake(textRect.origin.x + _starPoint.x * textRect.size.width,
                                     textRect.origin.y + _starPoint.y * textRect.size.height);
    CGPoint endPoint = CGPointMake(textRect.origin.x + _endPoint.x * textRect.size.width,
                                   textRect.origin.y + _endPoint.y * textRect.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
    
    CGGradientRelease(gradient);
    CGImageRelease(alphaMask);
}

- (UIColor *)color:(CGColorRef)a blendedWithColor:(CGColorRef)b
{
    CGFloat aRGBA[4];
    [self getComponents:aRGBA forColor:a];
    CGFloat bRGBA[4];
    [self getComponents:bRGBA forColor:b];
    CGFloat source = aRGBA[3];
    CGFloat dest = 1.0f - source;
    return [UIColor colorWithRed:source * aRGBA[0] + dest * bRGBA[0]
                           green:source * aRGBA[1] + dest * bRGBA[1]
                            blue:source * aRGBA[2] + dest * bRGBA[2]
                           alpha:bRGBA[3] + (1.0f - bRGBA[3]) * aRGBA[3]];
}

- (void)getComponents:(CGFloat *)rgba forColor:(CGColorRef)color
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(color));
    const CGFloat *components = CGColorGetComponents(color);
    switch (model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
        case kCGColorSpaceModelRGB:
        {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }
        default:
        {
            NSLog(@"Unsupported gradient color format: %i", model);
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}

@end
