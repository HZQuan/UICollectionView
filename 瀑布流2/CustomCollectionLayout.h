//
//  CustomCollectionLayout.h
//  瀑布流2
//
//  Created by 黄增权 on 15/11/3.
//  Copyright (c) 2015年 黄增权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionLayout : UICollectionViewLayout
@property (nonatomic ,assign) NSInteger columCounts;
@property (nonatomic ,assign) NSInteger spacingWith;
@property (nonatomic ,assign) CGFloat fullWidth;
@property (nonatomic ,strong) NSMutableArray *hightArray;
@property (nonatomic ,strong) NSDictionary *dictonary;
@property (nonatomic ,strong) NSMutableArray *celleYArray;

@end
