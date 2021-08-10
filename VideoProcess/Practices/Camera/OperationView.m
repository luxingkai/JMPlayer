//
//  OperationView.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/28.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "OperationView.h"

@implementation OperationCell {
    UILabel *_titleLab;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return self;
}

#pragma mark -- setter

- (void)setTitle:(NSString *)title {
    if (_title == title) return;
    _titleLab.text = title;
}

@end

@interface OperationView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation OperationView {
    
    UICollectionView *_collectionView;
    NSArray *_titles;
}

static NSString *const identifier = @"identifier";
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        _titles = @[@"视频",@"拍照",@"全景"];
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.frame.size.width/3.0, 34);
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 34) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor blackColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[OperationCell class] forCellWithReuseIdentifier:identifier];
    
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = CGRectMake(0, 0, 60, 60);
    takePhotoBtn.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 30);
    [takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [takePhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [takePhotoBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:18]];
    [takePhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:takePhotoBtn];
    
}

#pragma mark --

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OperationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.title = _titles[indexPath.row];
    return cell;
}

#pragma mark --

- (void)takePhoto {
    
    if ([_delegate respondsToSelector:@selector(operation)]) {
        [_delegate operation];
    }
}


@end
