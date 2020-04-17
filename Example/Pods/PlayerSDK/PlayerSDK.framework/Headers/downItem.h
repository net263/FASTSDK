//
//  downItem.h
//  genseeFrameWork
//
//  Created by gs_mac_fjb on 15-1-26.
//  Copyright (c) 2015年 gensee. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "vodHead.h"

@interface downItem : NSObject

@property(nonatomic,strong)NSString *strDownloadID;
@property(nonatomic,strong)NSString *strURL;
@property(nonatomic,assign)DOWNSTATE state;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString *tid;
@property(nonatomic,strong)NSString *fileSize;
@property(nonatomic,strong)NSString *downLoadedSize;

@property(nonatomic,assign)LONGLONG llSiteID;
@property(nonatomic,assign)LONGLONG llUserID;
@property(nonatomic,strong)NSString *strUserName;
@property(nonatomic,strong)NSString *strAlbAddress;
@property(nonatomic,assign)int  nServiceType;
@property(nonatomic,assign)int  downFlag;
@property(nonatomic,strong)NSString *mDomain;

@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *starttime;

@property (nonatomic, assign) NSInteger sc;

@property (nonatomic, assign) long long hostID;

@property (nonatomic, copy) NSString *cdnList;

@property (nonatomic, assign)int loopFlag;

//3.6.3

//下载进度
@property (nonatomic, assign) float percent;

//3.7.4
@property (nonatomic,strong) NSString *albport;

//3.7.9
@property (nonatomic, strong) NSString *vodDescription;
@property (nonatomic, strong) NSString *scheduleInfo;
@property (nonatomic, strong) NSString *speakerInfo;

// 获取点播的大小，日期信息
- (void)requestMoreInfo:(void (^)(BOOL isSuccess, NSString* fileSize, NSString* startTime, NSString *endTime))completion;
@end