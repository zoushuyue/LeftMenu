//
//  LeftMenuModel.m
//  LeftMenu
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "LeftMenuModel.h"

@implementation LeftMenuModel

- (instancetype) initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}


+ (instancetype) leftMenuWithDict:(NSDictionary *)dict {
    
    return [[self alloc]initWithDict:dict];
    
}

+ (NSArray *) menuModel {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Menus" ofType:@"plist"]];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        
        LeftMenuModel  *menus = [LeftMenuModel leftMenuWithDict:dict];
        
        [arrayM addObject:menus];
        
    }
    
    return arrayM;
    
}

@end