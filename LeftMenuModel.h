//
//  LeftMenuModel.h
//  LeftMenu
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftMenuModel : NSObject

@property (nonatomic, copy) NSString *text;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) leftMenuWithDict:(NSDictionary *)dict;

+ (NSArray *) menuModel;

@end
