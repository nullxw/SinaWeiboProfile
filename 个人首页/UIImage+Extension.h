//
//  UIImage+Extension.h
//  个人首页
//
//  Created by Yahui on 15/7/31.
//  Copyright (c) 2015年 Yahui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
