//
//  MTAAdviseInfo.h
//  Jovi
//
//  Created by yuzhuo on 2016/12/21.
//  Copyright © 2016年 dianping.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTAAdviseInfo : NSObject

/** desc */
@property (nonatomic,strong) NSString *desc;

/** color */
@property (nonatomic,strong) NSString *color;

/** bold */
@property (nonatomic,assign) Boolean bold;

/** target */
@property (nonatomic,strong) NSString *target;

@end
