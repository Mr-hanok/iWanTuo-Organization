//
//  NewVersionViewController.m
//  DoctorYL
//
//  Created by maple on 15/4/14.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "NewVersionViewController.h"
#import "NewVersionCollectionCell.h"
@interface NewVersionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation NewVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layout.itemSize = [UIScreen mainScreen].bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumLineSpacing = 0;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewVersionCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewVersionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell setImgaeWithRow:indexPath.row];
    
    return cell;
}






@end
