//
//  UIVerticalLoopView.h
//  Jovi
//
//  Created by yuzhuo on 2016/11/23.
//  Copyright © 2016年 dianping.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTANewAdviseInfo.h"

@protocol VerticalLoopDelegate<NSObject>

- (void)didClickContentAtIndex:(NSInteger)index;

@end
typedef enum
{
    VerticalLoopDirectionBottom,
    VerticalLoopDirectionDown,
    
}VerticalLoopDirection;

@interface MTAVerticalLoopView : UIView
{
    
    // 创建两个label循环滚动
    UILabel *_firstContentLabel;
    UILabel *_secondContentLabel;
    
    UILabel *_firstclickLabel;
    UILabel *_secondclickLabel;
    // 记录
    int currentIndex;
    
}
/** 动画方向默认往上
 *  跑马灯动画时间
 */
@property(nonatomic) float verticalLoopAnimationDuration;
/**
 *  显示的内容(支持多条数据)
 */
@property(nonatomic, retain) NSMutableArray<MTANewAdviseInfo *> *data;
/**
 * loop方向(上下/右)
 */
@property(nonatomic) VerticalLoopDirection Direction;
@property (nonatomic, weak)id<VerticalLoopDelegate> loopDelegate;
/**
 *  开启
 */
-(void)start;

- (void)loopContentClick;

@end
