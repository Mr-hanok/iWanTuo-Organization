//
//  AccountListViewController.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "BaseViewController.h"
#import "PatriarchModel.h"

typedef void (^BackBlock)(PatriarchModel *model);
@interface AccountListViewController : BaseViewController

@property (nonatomic, copy) BackBlock backBlock;

@end
