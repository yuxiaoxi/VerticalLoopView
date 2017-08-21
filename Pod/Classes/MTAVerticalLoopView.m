//
//  UIVerticalLoopView.m
//  Jovi
//
//  Created by yuzhuo on 2016/11/23.
//  Copyright © 2016年 dianping.com. All rights reserved.
//

#import "MTAVerticalLoopView.h"

@implementation MTAVerticalLoopView
{
    BOOL _animating;
}

#pragma mark - lifecycle
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
    }
    return self;
}

#pragma mark - private method
-(void)setupView {
    
    _firstclickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 10, 50, 25)];
    _firstclickLabel.font = [UIFont systemFontOfSize:11.0];
    [_firstclickLabel.layer setBorderColor:[UIColor blueColor].CGColor];//边框颜色
    [_firstclickLabel.layer setMasksToBounds:YES];
    [_firstclickLabel.layer setCornerRadius:12.5];
    [_firstclickLabel.layer setBorderWidth:1.0];
    _firstclickLabel.textColor = [UIColor blueColor];
    _firstclickLabel.textAlignment = NSTextAlignmentCenter;
    
    _secondclickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-50, self.frame.size.height+10, 50, 25)];
    _secondclickLabel.font = [UIFont systemFontOfSize:11.0];
    [_secondclickLabel.layer setBorderColor:[UIColor blueColor].CGColor];//边框颜色
    [_secondclickLabel.layer setMasksToBounds:YES];
    [_secondclickLabel.layer setCornerRadius:12.5];
    [_secondclickLabel.layer setBorderWidth:1.0];
    _secondclickLabel.textColor = [UIColor blueColor];
    _secondclickLabel.textAlignment = NSTextAlignmentCenter;

    _firstContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 70, self.frame.size.height)];
    [_firstContentLabel setBackgroundColor:[UIColor clearColor]];
    [_firstContentLabel setNumberOfLines:0];
    _firstContentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecongnizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer1.numberOfTapsRequired = 1;
    [_firstContentLabel addGestureRecognizer:tapGesturRecongnizer1];
    
//    _firstContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_firstContentLabel setTextColor:[UIColor grayColor]];
    _firstContentLabel.font=[UIFont boldSystemFontOfSize:12.f];
    
    _secondContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height , self.frame.size.width - 70, self.frame.size.height)];
    [_secondContentLabel setBackgroundColor:[UIColor clearColor]];
    [_secondContentLabel setTextColor:[UIColor grayColor]];
//    _secondContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_secondContentLabel setNumberOfLines:0];
    _secondContentLabel.userInteractionEnabled = YES;
    _secondContentLabel.font=[UIFont boldSystemFontOfSize:12.f];
    
    UITapGestureRecognizer *tapGesturRecongnizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer2.numberOfTapsRequired = 1;
    [_secondContentLabel addGestureRecognizer:tapGesturRecongnizer2];
    
    [self addSubview:_firstContentLabel];
    [self addSubview:_secondContentLabel];
    [self addSubview:_firstclickLabel];
    [self addSubview:_secondclickLabel];
    
    // 默认初始方向是向上
    _Direction = VerticalLoopDirectionDown;
    _verticalLoopAnimationDuration = 0.5;
    self.clipsToBounds = YES;
}

-(void) setData:(NSMutableArray<MTANewAdviseInfo *> *) data{
    _data = data;
}



-(void)startVerticalLoopAnimation{
    NSMutableArray<MTANewAdviseInfo *> *data = [self.data copy];
    if (currentIndex >= data.count) {
        [self verticalLoopAnimationDidStop:nil finished:nil context:nil];
        return;
    }
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    //创建 NSMutableAttributedString
    MTANewAdviseInfo * firstAd = [data objectAtIndex:currentIndex];
    NSMutableAttributedString *attributedStr01 = [[NSMutableAttributedString alloc] initWithString: firstAd.desc];
    [attributedStr01 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [firstAd.desc length])];
    //添加属性
    //分段控制，最开始4个字符颜色设置成颜色
    
    for(int i = 0;i<firstAd.styleArray.count;i++){
        NSInteger targetLength = firstAd.styleArray[i].target.length;
        if(firstAd.styleArray[i].color !=nil && targetLength >0){
            [attributedStr01 addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: [firstAd.desc rangeOfString:firstAd.styleArray[i].target]];
        }
        
        if(firstAd.styleArray[i].bold && targetLength >0){
            [attributedStr01 addAttribute:NSStrokeWidthAttributeName value:@(-3) range:[firstAd.desc rangeOfString:firstAd.styleArray[i].target]];
        }
    }
    
    //赋值给显示控件label01的 attributedText
    _firstContentLabel.attributedText = attributedStr01;
    [_firstContentLabel setNeedsDisplay];
    
    _firstclickLabel.text = firstAd.operateDesc;
    
    float firstContentLaStartY = 0;
    float firstContentLaEndY = 0;
    float secondContentLaStartY = 0;
    float secondContentLaEndY = 0;
    
    int secondCurrentIndex  = currentIndex + 1;
    if (secondCurrentIndex > data.count - 1) {
        secondCurrentIndex = 0;
    }
    
    switch (_Direction) {
        case VerticalLoopDirectionBottom:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY - self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY - self.frame.size.height;
            
            break;
        case VerticalLoopDirectionDown:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = -self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY + self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY + self.frame.size.height;
            
            break;
        default:
            break;
    }
    
    MTANewAdviseInfo * secondAd = [data objectAtIndex:secondCurrentIndex];
    NSMutableAttributedString *attributedStr02 = [[NSMutableAttributedString alloc] initWithString: secondAd.desc];
    
    
    [attributedStr02 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [secondAd.desc length])];
    
    //添加属性
    //分段控制，最开始4个字符颜色设置成颜色
    for(int i = 0;i<secondAd.styleArray.count;i++){
        NSInteger targetLength02 = secondAd.styleArray[i].target.length;
        if(secondAd.styleArray[i].color !=nil && targetLength02 >0){
            [attributedStr02 addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: [secondAd.desc rangeOfString:secondAd.styleArray[i].target]];
        }
        if(secondAd.styleArray[i].bold && targetLength02 >0){
            [attributedStr02 addAttribute:NSStrokeWidthAttributeName value:@(-3) range:[secondAd.desc rangeOfString:secondAd.styleArray[i].target]];
        }

    }
    
    _secondContentLabel.attributedText = attributedStr02;
    [_secondContentLabel setNeedsDisplay];
    _secondclickLabel.text = secondAd.operateDesc;
    
    _firstContentLabel.frame = CGRectMake(10, firstContentLaStartY, self.frame.size.width - 70, self.frame.size.height);
    _secondContentLabel.frame = CGRectMake(10, secondContentLaStartY, self.frame.size.width - 70, self.frame.size.height);
    
    _firstclickLabel.frame = CGRectMake(self.frame.size.width-50, firstContentLaStartY+10, 50, 25);
    _secondclickLabel.frame = CGRectMake(self.frame.size.width-50, secondContentLaStartY+10, 50, 25);
    
//    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        @strongify(self);
        [self didAnimation:firstContentLaEndY secondContent:secondContentLaEndY];
    });
    
}

-(void)verticalLoopAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    currentIndex++;
    if(currentIndex >= [self.data count]) {
        currentIndex = 0;
    }
//    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        @strongify(self);
        [self startVerticalLoopAnimation];
    });
    
    
}
- (void)loopContentClick
{
    if ([self.loopDelegate respondsToSelector:@selector(didClickContentAtIndex:)]) {
        [self.loopDelegate didClickContentAtIndex:currentIndex];
    }
}

#pragma mark - verticalLoop Animation Handling
-(void)start {
    
    // 开启动画默认第一条信息
    currentIndex = 0;
    // 开始动画
    if (!_animating) {
        _animating = YES;
        [self performSelectorOnMainThread:@selector(startVerticalLoopAnimation) withObject:nil waitUntilDone:NO];
//        [self startVerticalLoopAnimation];
    }
}

-(void)didAnimation:(float)firstContentLaEndY secondContent:(float)secondContentLaEndY
{
    if([self.data count]>1){
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:_verticalLoopAnimationDuration];
        [UIView setAnimationDelay:5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(verticalLoopAnimationDidStop:finished:context:)];
        CGRect firstContentLabelFrame = _firstContentLabel.frame;
        firstContentLabelFrame.origin.y = firstContentLaEndY;

        [_firstContentLabel setFrame:firstContentLabelFrame];
        [_secondContentLabel setFrame:CGRectMake(10,secondContentLaEndY, self.frame.size.width - 70, self.frame.size.height)];
        
        CGRect firstClickLabelFrame = _firstclickLabel.frame;
        firstClickLabelFrame.origin.y = firstContentLaEndY+10;
        [_firstclickLabel setFrame:firstClickLabelFrame];
        [_secondclickLabel setFrame:CGRectMake(self.frame.size.width-50, secondContentLaEndY+10, 50, 25)];
        
        [UIView commitAnimations];
    }else{
        _animating = NO;
    }

}

@end
