//  GSVodParamController.m
//  VodSDKDemo
//  Created by Sheng on 2018/8/3.
//  Copyright © 2018年 Gensee. All rights reserved.

#import "GSFastVodController.h"
#import "GSTextFieldTitleView.h"
#import <GSCommonKit/GSCommonKit.h>
#import "IQKeyboardManager.h"
#import <PlayerSDK/VodSDK.h>
#import <PlayerSDK/PlayerSDK.h>
#import <FASTSDK/FASTSDK.h>
#define FASTSDK_COLOR16(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]
#define MO_DOMAIN @"V_FAST_CONFIG_DOMAIN"
#define MO_SERVICE @"V_FAST_CONFIG_SERVICE_TYPE"
#define MO_ROOMID @"V_FAST_CONFIG_ROOMID"
#define MO_NICKNAME @"V_FAST_CONFIG_NICKNAME"
#define MO_PWD @"V_FAST_CONFIG_PWD"
#define MO_LOGIN_NAME @"V_FAST_CONFIG_LOGIN_NAME"
#define MO_LOGIN_PWD @"V_FAST_CONFIG_LOGIN_PWD"
#define MO_THIRD_KEY @"V_FAST_CONFIG_THIRD_KEY"
#define MO_REWARD @"V_FAST_CONFIG_REWARD"
#define MO_USERID @"V_FAST_CONFIG_USERID"
#define MO_SEEK_POSITION @"V_FAST_CONFIG_SEEK_POSITION"

@interface GSFastVodController() <UITextFieldDelegate>
//UI
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSMutableDictionary  *fieldViewsDic;
//config
@property (strong, nonatomic) UISegmentedControl *serviceType;
@property (strong, nonatomic) UISegmentedControl *flvType;
@property (strong, nonatomic) UISegmentedControl *httpType;
@property (strong, nonatomic) UISegmentedControl *decodeType;
@property (strong, nonatomic) GSFastSDKConfig *config;
@end

@implementation GSFastVodController
{
    struct {
        unsigned int isOnline : 1;
    } _state;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.config = [GSFastSDKConfig new];
    self.config.moduleStyle = GSFastModuleVODAllStyles;
    
    //UI
    self.title = @"FAST中的点播";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _fieldViewsDic = [[NSMutableDictionary alloc]init];
    self.scrollView                     = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64 - 50)];
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    CGFloat top = 10.f;
    int index = 0;
    
    UILabel *label = [self createTagLabel:@"点播参数设置" top:top];
    [self.scrollView addSubview:label];
    top = label.bottom + 5;
    
    UIView *whiteBGView  = [self createWhiteBGViewWithTop:top itemCount:9];
    top = whiteBGView.bottom + 10;
    [self.scrollView addSubview:whiteBGView];
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"域名";
        fieldView.placeHolder               = @"请输入域名";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_DOMAIN];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"房间号";
        fieldView.placeHolder               = @"请输入房间号";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        fieldView.field.keyboardType = UIKeyboardTypeNumberPad;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_ROOMID];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"昵称";
        fieldView.placeHolder               = @"请输入昵称";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_NICKNAME];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"房间密码";
        fieldView.placeHolder               = @"请输入房间密码(可选)";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        //        fieldView.field.keyboardType = UIKeyboardTypeNumberPad;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_PWD];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"登录用户名";
        fieldView.placeHolder               = @"请输入登录用户名(可选)";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_LOGIN_NAME];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"登录密码";
        fieldView.placeHolder               = @"请输入登录密码(可选)";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_LOGIN_PWD];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"第三方验证码";
        fieldView.placeHolder               = @"请输入验证码(可选)";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_THIRD_KEY];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"自定义用户ID";
        fieldView.placeHolder               = @"请输入ID(可选,且应大于十亿)";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        fieldView.field.keyboardType = UIKeyboardTypeNumberPad;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_USERID];
        index ++;
    }
    {
        GSTextFieldTitleView *fieldView       = [[GSTextFieldTitleView alloc] initWithFrame:CGRectMake(0, index * 40.f, Width, 40.f)];
        fieldView.title                     = @"开始播放位置";
        fieldView.placeHolder               = @"请输入开始播放位置(毫秒数)";
        //        fieldView.field.delegate            = self;
        fieldView.field.clearButtonMode = UITextFieldViewModeAlways;
        fieldView.field.keyboardType = UIKeyboardTypeNumberPad;
        [whiteBGView addSubview:fieldView];
        [_fieldViewsDic setObject:fieldView forKey:MO_SEEK_POSITION];
        index ++;
    }
    
    //segement
    {
        UILabel *label = [self createTagLabel:@"站点类型" top:top];
        [self.scrollView addSubview:label];
        
        UILabel *label1 = [self createTagLabel:@"FLV" top:top left:Width/2 + 15];
        [self.scrollView addSubview:label1];
        top = label.bottom + 5;
        //Webcast/Trainig
        _serviceType = [[UISegmentedControl alloc] initWithItems:@[@"Webcast",@"Training"]];
        _serviceType.frame = CGRectMake(15, top, (Width - 60)/2, 28);
        _serviceType.tag = 0;
        //        _serviceType
        _serviceType.selectedSegmentIndex = 0;
        //        [_serviceType addTarget:self action:@selector(segementChanged:) forControlEvents:UIControlEventValueChanged];
        [self.scrollView addSubview:_serviceType];
        //Theme
        _flvType = [[UISegmentedControl alloc] initWithItems:@[@"否",@"是"]];
        _flvType.frame = CGRectMake(Width/2 + 15, top, (Width - 60)/2, 28);
        _flvType.selectedSegmentIndex = 0;
        _flvType.tag = 1;
        //        [_flvType addTarget:self action:@selector(segementChanged:) forControlEvents:UIControlEventValueChanged];
        [self.scrollView addSubview:_flvType];
        
        top = _flvType.bottom + 10;
        
        UILabel *label2 = [self createTagLabel:@"HTTP/HTTPS" top:top];
        [self.scrollView addSubview:label2];
        
        UILabel *label3 = [self createTagLabel:@"软解/硬解" top:top left:Width/2 + 15];
        [self.scrollView addSubview:label3];
        top = label2.bottom + 5;
        //HTTP/HTTPS
        _httpType = [[UISegmentedControl alloc] initWithItems:@[@"HTTP",@"HTTPS"]];
        _httpType.frame = CGRectMake(15, top, (Width - 60)/2, 28);
        _httpType.tag = 2;
        _httpType.selectedSegmentIndex = 0;
        //        [_httpType addTarget:self action:@selector(segementChanged:) forControlEvents:UIControlEventValueChanged];
        [self.scrollView addSubview:_httpType];
        
        
        //HTTP/HTTPS
        _decodeType = [[UISegmentedControl alloc] initWithItems:@[@"软解",@"硬解"]];
        _decodeType.frame = CGRectMake(Width/2 + 15, top, (Width - 60)/2, 28);
        _decodeType.tag = 3;
        _decodeType.selectedSegmentIndex = 1;
        //        [_httpType addTarget:self action:@selector(segementChanged:) forControlEvents:UIControlEventValueChanged];
        [self.scrollView addSubview:_decodeType];
        top = _decodeType.bottom + 10;
        
        
        
    }
    
    //模块配置
    {
        UILabel *label = [self createTagLabel:@"模块配置" top:top];
        [self.scrollView addSubview:label];
        
        top = label.bottom + 5;
        GSTagsContentView *tagContent = [[GSTagsContentView alloc] initWithFrame:CGRectMake(15, top , self.view.bounds.size.width - 30, 40) tags:@[@"文档",@"章节",@"聊天",@"问答",@"简介"] handler:^(NSInteger index, NSString *text,BOOL isSelect) {
            NSLog(@"选择 %zd : %@ ,Select : %d",index,text,isSelect);
            switch (index) {
                case 0://文档
                    self.config.moduleStyle = (self.config.moduleStyle)^(GSFastModuleDoc);
                    break;
                case 1://章节
                    self.config.moduleStyle = (self.config.moduleStyle)^(GSFastModuleVodSection);
                    break;
                case 2://聊天
                    self.config.moduleStyle = (self.config.moduleStyle)^(GSFastModuleChat);
                    break;
                case 3://问答
                    self.config.moduleStyle = (self.config.moduleStyle)^(GSFastModuleQa);
                    break;
                case 4://简介
                    self.config.moduleStyle = (self.config.moduleStyle)^(GSFastModuleIntroduction);
                    break;
                    
                default:
                    break;
            }
        }];
        tagContent.defaultSelected = YES;
        tagContent.allowSelect = YES;
        tagContent.supportMultiSelect = YES;
        [self.scrollView addSubview:tagContent];
        top = tagContent.bottom + 10;
    }
    //NSUserDefault
    [self loadCache];
    
    self.scrollView.contentSize = CGSizeMake(Width, top);
    
    {
        //按钮事件 - 观看
        UIButton *watch   = [[UIButton alloc] initWithFrame:CGRectMake(15, Height - 50.f + 5, Width-30, 40.f)];
        [watch setTitle:@"在线观看" forState:UIControlStateNormal];
        watch.layer.cornerRadius         = 3.f;
        watch.layer.borderColor          = FASTSDK_COLOR16(0x009BD8).CGColor;
        watch.layer.borderWidth          = 0.5f;
        watch.layer.masksToBounds        = YES;
        watch.backgroundColor = FASTSDK_COLOR16(0x009BD8);
        [watch addTarget:self action:@selector(watch:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:watch];
    }
    
}

- (void)watch:(UIButton*)sender {
    sender.userInteractionEnabled = NO;
    
    //存储相关参数到NSUserDefault
    [self saveCache];
    
    //param
    VodParam *params = [VodParam new];
#if 1
    params.domain = [self _fieldText:MO_DOMAIN];
    params.number = [self _fieldText:MO_ROOMID];
    params.loginName = [self _fieldText:MO_LOGIN_NAME];
    params.vodPassword = [self _fieldText:MO_PWD];
    params.loginPassword = [self _fieldText:MO_LOGIN_PWD];
    params.nickName = [self _fieldText:MO_NICKNAME];
    params.serviceType = self.serviceType.selectedSegmentIndex == 0?@"webcast":@"training";;
    params.thirdToken = [self _fieldText:MO_THIRD_KEY];
    if ([self _fieldText:MO_USERID].length > 0) {
        params.customUserID = [[self _fieldText:MO_USERID] longLongValue];
    }
    
    if([self _fieldText:MO_SEEK_POSITION].length > 0)
    {
        params.seekPosition = [[self _fieldText:MO_SEEK_POSITION] longLongValue];
    }
#else
    params.domain = @"213.gensee.com";
    params.serviceType = self.serviceType.selectedSegmentIndex == 0?@"webcast":@"training";;
    //    info.number = @"10142713";
    params.number = @"34042325";
    params.nickName = @"Gensee";
    params.vodPassword = @"444444";
//    bocstudy1.gensee.com/webcast/site/vod/play-5fc0e7df883b40b69b651e62a7f549df
//    params.domain = @"edusoho.gensee.com";
////    params.number = @"20207801";
//    params.vodID = @"ilfl28VziC";
//    params.vodPassword = @"5cfe0d4494abf";
//    params.nickName = @"support";
//    params.serviceType = self.serviceType.selectedSegmentIndex == 0?@"webcast":@"training";;
//    params.oldVersion = NO;
//    params.thirdToken = @"1575364097bd7c54f27be33d895f8d41";
    if ([self _fieldText:MO_USERID].length > 0) {
        params.customUserID = [[self _fieldText:MO_USERID] longLongValue];
    }
    if([self _fieldText:MO_SEEK_POSITION].length > 0)
    {
        params.seekPosition = [[self _fieldText:MO_SEEK_POSITION] longLongValue];
    }
#endif

    [GSVodManager sharedInstance].isHttps= _httpType.selectedSegmentIndex ==1?YES:NO;
    [GSVodManager sharedInstance].isFlv= _flvType.selectedSegmentIndex == 1?YES:NO;
    [GSVodManager sharedInstance].player.hardwareAccelerate = _decodeType.selectedSegmentIndex == 1?YES:NO;
    self.config.isHttps = _httpType.selectedSegmentIndex ==1?YES:NO;
    self.config.isFlv = _flvType.selectedSegmentIndex == 1?YES:NO;;
    [[GSFastSDK sharedInstance] enterVod:params config: self.config animate:YES completion:^{
        NSLog(@"进入点播");
    }];
    
    //设置间隔
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.userInteractionEnabled = YES;
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view resignFirstResponder];
}

//data
#pragma mark - data
- (void)saveCache {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.serviceType.selectedSegmentIndex] forKey:MO_SERVICE];
    [self _saveField:MO_DOMAIN];
    [self _saveField:MO_ROOMID];
    [self _saveField:MO_NICKNAME];
    [self _saveField:MO_PWD];
    [self _saveField:MO_LOGIN_NAME];
    [self _saveField:MO_LOGIN_PWD];
    [self _saveField:MO_THIRD_KEY];
    [self _saveField:MO_USERID];
    [self _saveField:MO_SEEK_POSITION];
    
}

- (void)_saveField:(NSString *)fieldMark {
    NSString *text = [self _fieldText:fieldMark];
    if (text.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:text forKey:fieldMark];
    }else{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:fieldMark]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:fieldMark];
        }
    }
}

- (NSString *)_fieldText:(NSString *)fieldMark {
    GSTextFieldTitleView *fieldView = [_fieldViewsDic objectForKey:fieldMark];
    return fieldView.field.text;
}

- (void)loadCache {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_DOMAIN]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"qa100.gensee.com" forKey:MO_DOMAIN];
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_DOMAIN];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_DOMAIN];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_SERVICE]) {
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:MO_SERVICE];
    }else{
        self.serviceType.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:MO_SERVICE] intValue];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_ROOMID]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"14949860" forKey:MO_ROOMID];
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_ROOMID];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_ROOMID];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_NICKNAME]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"genseeTest" forKey:MO_NICKNAME];
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_NICKNAME];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_NICKNAME];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_PWD]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:MO_PWD];
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_PWD];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_PWD];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_LOGIN_NAME]) {
        //do nothing
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_LOGIN_NAME];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_LOGIN_NAME];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_LOGIN_PWD]) {
        //do nothing
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_LOGIN_PWD];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_LOGIN_PWD];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_THIRD_KEY]) {
        //do nothing
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_THIRD_KEY];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_THIRD_KEY];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MO_USERID]) {
        //do nothing
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_USERID];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_USERID];
    }
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:MO_SEEK_POSITION])
    {
        
    }else{
        GSTextFieldTitleView *fieldview = [_fieldViewsDic objectForKey:MO_SEEK_POSITION];
        fieldview.field.text = [[NSUserDefaults standardUserDefaults] objectForKey:MO_SEEK_POSITION];
    }
}

- (void)dealloc {
    [_fieldViewsDic removeAllObjects];
    NSLog(@"GSFastConfigController dealloc");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
