//
//  Header.h
//  pan
//
//  Created by 于海涛 on 2017/11/29.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define Base_Url @"http://app.zoedear.com/app.php/"


/* 系统宽高 */
#define HitoScreenRect [UIScreen mainScreen].bounds
#define HitoScreenSize [UIScreen mainScreen].bounds.size
#define HitoScreenWidth [UIScreen mainScreen].bounds.size.width
#define HitoScreenHeight [UIScreen mainScreen].bounds.size.height
//状态栏高度
#define HitoStatusHeight [UIApplication sharedApplication].statusBarFrame.size.height
//导航栏高度
#define HitoNavHeight 44
//顶部高度
#define HitoTopHeight (HitoStatusHeight+HitoNavHeight)
//iPhoneX安全区域高度
#define HitoSafeAreaHeight (HitoStatusHeight>20?34:0)
//底部高度
#define HitoBottomHeight (49+HitoSafeAreaHeight)


#endif /* Header_h */
