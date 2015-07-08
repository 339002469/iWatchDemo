//
//  FDViewController.m
//  iWatch-Demo
//
//  Created by student on 15-5-7.
//  Copyright (c) 2015年 iFD. All rights reserved.
//

#import "FDViewController.h"

@interface FDViewController ()

@end

@implementation FDViewController
{
    UILabel *_secLabel;
    UILabel *_mSecLabel;
    int _h,_m,_s,_ms;
    BOOL isRunning;
    NSTimer *_timer;
}
- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
    }
    [_secLabel release];
    [_mSecLabel release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self creatButtons];
    [self creatLabels];
    [self creatTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建定时器
-(void)creatTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    _timer.fireDate=[NSDate distantFuture];
}
//搭建UI
//创建Button
-(void)creatButtons
{
    NSArray *titleArray=@[@"【开始】",@"【停止】",@"【复位】"];
    for (int i=0; i<titleArray.count; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(60, 150+i*70, 200, 60)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:40];
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchDown];
        button.tag=1+i;
        [self.view addSubview:button];
        [button release];
    }
}
//创建Label
-(void)creatLabels
{
    _secLabel=[[UILabel alloc]init];
    _mSecLabel=[[UILabel alloc]init];
    _secLabel.frame=CGRectMake(50, 50, 220, 100);
    _mSecLabel.frame=CGRectMake(250, 85, 50, 50);
    _secLabel.text=@"00:00:00";
    _mSecLabel.text=@"0";
    _secLabel.textColor=[UIColor blackColor];
    _mSecLabel.textColor=[UIColor redColor];
    _secLabel.textAlignment=NSTextAlignmentCenter;
    _mSecLabel.textAlignment=NSTextAlignmentCenter;
    
    _secLabel.font=[UIFont boldSystemFontOfSize:55];
    _mSecLabel.font=[UIFont boldSystemFontOfSize:25];
    
    [self.view addSubview:_secLabel];
    [self.view addSubview:_mSecLabel];
    [_secLabel release];
    [_mSecLabel release];
}
//点击事件分发
-(void)action:(UIButton *)button
{
    switch (button.tag) {
        case 1:
            //开始键
            [self startButton:button];
            break;
        case 2:
            //停止键
            [self stopButton];
            break;
        case 3:
            //复位键
            [self resetButton];
            break;
        default:
            break;
    }
}
//开始事件
-(void)startButton:(UIButton *)button
{
    if (isRunning==NO) {
        
        _timer.fireDate=[NSDate distantPast];
        [button setTitle:@"【暂停】" forState:UIControlStateNormal];
        isRunning=YES;
        
    }
    else
    {
        _timer.fireDate=[NSDate distantFuture];
        [button setTitle:@"【继续】" forState:UIControlStateNormal];
        isRunning=NO;
    }
}
//停止事件
-(void)stopButton
{
    _timer.fireDate=[NSDate distantFuture];
    UIButton *button=(UIButton *)[self.view viewWithTag:1];
    [button setTitle:@"【开始】" forState:UIControlStateNormal];
    _h=_m=_s=_ms=0;
    isRunning=NO;
}
//复位事件
-(void)resetButton
{
    [self stopButton];
    _ms=-1;
    [self refresh];
}
//计时器
-(void)refresh
{
    _ms++;
    if (_ms==10) {
        _ms=0;
        _s++;
        if (_s==60) {
            _s=0;
            _m++;
            if (_m==60) {
                _m=0;
                _h++;
                if (_h==100) {
                    _timer=[NSDate distantFuture];
                }
            }
        }
    }
    _secLabel.text=[NSString stringWithFormat:@"%02d:%02d:%02d",_h,_m,_s];
    _mSecLabel.text=[NSString stringWithFormat:@"%d",_ms];
}
@end
