//
//  StudentCell.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyStudentCellDelegate <NSObject>

- (void)myStudentCellCliecDeleBtn:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath;
@end

@interface StudentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, assign) id<MyStudentCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
