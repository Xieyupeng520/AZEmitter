//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface YQAnimationLayer : CALayer
/**
 *  字符串画线
 *
 *  @param string    要画的字符串
 *  @param rect      动画位置
 *  @param view      动画所在视图
 *  @param ui_font   动画字体
 *  @param color     字体颜色
 */
+(YQAnimationLayer*)createAnimationLayerWithString:(NSString*)string andRect:(CGRect)rect andView:(UIView*)view andFont:(UIFont*)ui_font andStrokeColor:(UIColor*)color;
@end
