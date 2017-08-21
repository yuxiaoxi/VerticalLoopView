//
//  MTANewAdviseInfo.h
//  Jovi
//
//  Created by yuzhuo on 2017/1/4.
//  Copyright © 2017年 dianping.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAAdviseInfo.h"

@interface MTANewAdviseInfo : NSObject

/** desc */
@property (nonatomic,strong) NSString *desc;

/** styleArray */
@property (nonatomic,strong) NSMutableArray<MTAAdviseInfo *> *styleArray;

/** operateDesc */
@property (nonatomic,strong) NSString *operateDesc;
@end
