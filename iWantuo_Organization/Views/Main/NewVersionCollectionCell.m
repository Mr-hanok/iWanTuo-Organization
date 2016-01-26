//
//  NewVersionCollectionCell.m
//  DoctorYL
//
//  Created by maple on 15/4/14.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "NewVersionCollectionCell.h"
#import "SystemHandler.h"


@interface NewVersionCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;


@end

@implementation NewVersionCollectionCell

- (void)awakeFromNib
{
    self.imageView = [[UIImageView alloc] init];
    
    [self insertSubview:self.imageView atIndex:0];
}

- (IBAction)skip {
    [self chooseRootVc];
}

- (IBAction)enter {
    [self chooseRootVc];
}

- (void)chooseRootVc
{
    //设置根视图控制器
    self.window.rootViewController = [SystemHandler mainViewController];

}

- (void)setImgaeWithRow:(NSInteger)row
{
    NSString *imgName = [NSString stringWithFormat:@"new_version_%@.jpg",@(row + 1)];
    self.imageView.image = [UIImage imageNamed:imgName];

    if (row == 3) {
        self.enterBtn.hidden = NO;
    } else {
        self.enterBtn.hidden = YES;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
