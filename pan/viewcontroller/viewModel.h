//
//  viewModel.h
//  pan
//
//  Created by 于海涛 on 2017/12/5.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface viewModel : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * img;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
