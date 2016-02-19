//
//  ActivityDetailViewController.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
