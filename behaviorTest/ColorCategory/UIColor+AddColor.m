//
//  UIColor+AddColor.m
//  FlatUI
//
//  Created by lzhr on 5/3/13.
//  Copyright (c) 2013 lzhr. All rights reserved.
//

#import "UIColor+AddColor.h"

@implementation UIColor (AddColor)


+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *) ngaBackColor
{
    return [UIColor colorWithRed:253.0f/255.0f green:243.0f/255.0f blue:216.0f/255.0f alpha:1];
}

+ (UIColor *) ngaDarkColor
{
    return [UIColor colorWithRed:249.0f/255.0f green:238.0f/255.0f blue:167.0f/255.0f alpha:1];
}

+ (UIColor *) turquoiseColor {
    return [UIColor colorFromHexCode:@"1ABC9C"];
}

+ (UIColor *) greenSeaColor {
    return [UIColor colorFromHexCode:@"16A085"];
}

+ (UIColor *) emerlandColor {
    return [UIColor colorFromHexCode:@"2ECC71"];
}

+ (UIColor *) nephritisColor {
    return [UIColor colorFromHexCode:@"27AE60"];
}

+ (UIColor *) peterRiverColor {
    return [UIColor colorFromHexCode:@"3498DB"];
}

+ (UIColor *) belizeHoleColor {
    return [UIColor colorFromHexCode:@"2980B9"];
}

+ (UIColor *) amethystColor {
    return [UIColor colorFromHexCode:@"9B59B6"];
}

+ (UIColor *) wisteriaColor {
    return [UIColor colorFromHexCode:@"8E44AD"];
}

+ (UIColor *) wetAsphaltColor {
    return [UIColor colorFromHexCode:@"34495E"];
}

+ (UIColor *) midnightBlueColor {
    return [UIColor colorFromHexCode:@"2C3E50"];
}

+ (UIColor *) sunflowerColor {
    return [UIColor colorFromHexCode:@"F1C40F"];
}

+ (UIColor *) tangerineColor {
    return [UIColor colorFromHexCode:@"F39C12"];
}

+ (UIColor *) carrotColor {
    return [UIColor colorFromHexCode:@"E67E22"];
}

+ (UIColor *) pumpkinColor {
    return [UIColor colorFromHexCode:@"D35400"];
}

+ (UIColor *) alizarinColor {
    return [UIColor colorFromHexCode:@"E74C3C"];
}

+ (UIColor *) pomegranateColor {
    return [UIColor colorFromHexCode:@"C0392B"];
}

+ (UIColor *) cloudsColor {
    return [UIColor colorFromHexCode:@"ECF0F1"];
}

+ (UIColor *) silverColor {
    return [UIColor colorFromHexCode:@"BDC3C7"];
}


+ (UIColor *) concreteColor {
    return [UIColor colorFromHexCode:@"95A5A6"];
}


+ (UIColor *) asbestosColor {
    return [UIColor colorFromHexCode:@"7F8C8D"];
}


+ (UIColor *) huiseColor {
    return [UIColor colorFromHexCode:@"ECF0F1"];
}


+ (UIColor *) shenhuiseColor{
    return [UIColor colorFromHexCode:@"A9B7B7"];
}


+ (UIColor *) tiankonglan {
    return [UIColor colorFromHexCode:@"56ABE4"];
}


+(UIColor *)qianhuiColor
{
    return [UIColor colorFromHexCode:@"f3f3f3"];
}


+ (UIColor *)menuColor
{
    return [UIColor colorFromHexCode:@"f7463e"];
}


+ (UIColor *) hongse {
    return [UIColor colorFromHexCode:@"EB4F38"];
}


+ (UIColor *) anheiColor {
    return [UIColor colorFromHexCode:@"404040"];
}


+ (UIColor *) qing {
    return [UIColor colorFromHexCode:@"009ad6"];
}


+ (UIColor *) fontColor
{
    return [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1];
}


+ (UIColor *) fontLightColor
{
    return [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1];
}


+ (UIColor *) mainRedColor
{
    return [UIColor colorWithRed:200.0f/255.0f green:22.0f/255.0f blue:30.0f/255.0f alpha:1];
}


+ (UIColor *) mainGreenColor
{
    return [UIColor colorWithRed:67.0f/255.0f green:142.0f/255.0f blue:56.0f/255.0f alpha:1];
}


+ (UIColor *) bottomBlackColor
{
    return [UIColor colorWithRed:17.0f/255.0f green:18.0f/255.0f blue:25.0f/255.0f alpha:1];
}


+ (UIColor *) buttonColor
{
    return [UIColor colorWithRed:60.0f/255.0f green:180.0f/255.0f blue:210.0f/255.0f alpha:1];
}


+ (UIColor *) alphaBlackColor
{
    return [UIColor colorWithRed:51.0f/255.0f green:55.0f/255.0f blue:58.0f/255.0f alpha:1];
}


+ (UIColor *) alphaDarkBlackColor
{
    return [UIColor colorWithRed:38.0f/255.0f green:41.0f/255.0f blue:44.0f/255.0f alpha:1];
}


+ (UIColor *) lineColor
{
    return [UIColor colorWithRed:93.0f/255.0f green:91.0f/255.0f blue:92.0f/255.0f alpha:1];
}


+ (UIColor *) trendLineBackColor
{
    return [UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:0.6];
}


+ (UIColor *) bottomImageTopColor
{
    return [UIColor colorWithRed:17.0f/255.0f green:18.0f/255.0f blue:25.0f/255.0f alpha:0.9];
}


+ (UIColor *) bottomLineColor
{
    return [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1];
    
}


+ (UIColor *) bottomButtonColor
{
    return [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
}


+ (UIColor *) buttonSelectedColor
{
    return [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1];
}


+ (UIColor *) enableEditColor
{
    return [UIColor colorWithRed:55.0f/255.0f green:55.0f/255.0f blue:55.0f/255.0f alpha:1];
}


+ (UIColor *) loadBlackColor
{
    return [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6];
}

+ (UIColor *) tipYellowColor
{
     return [UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:0.0f/255.0f alpha:1];
    
}

@end
