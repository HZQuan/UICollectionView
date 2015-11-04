
//
//  CustomCollectionLayout.m
//  瀑布流2
//
//  Created by 黄增权 on 15/11/3.
//  Copyright (c) 2015年 黄增权. All rights reserved.
//

#import "CustomCollectionLayout.h"

@implementation CustomCollectionLayout
-(void)prepareLayout
{
    self.spacingWith = 10;
    self.columCounts = 3;
    self.fullWidth = [UIScreen mainScreen].bounds.size.width;
    
    if (self.dictonary == nil) {
        self.dictonary = [NSMutableDictionary dictionary];
        
    }
    if (self.hightArray == nil) {
        self.hightArray = [NSMutableArray array];
        for (int i = 0; i<25; i++) {
            int a = arc4random()%200 + 50;
            
            [self.hightArray addObject:[NSString stringWithFormat:@"%d",a]];
        }
    }
    if (self.celleYArray == nil) {
        self.celleYArray = [NSMutableArray array];
        for (int i = 0; i<25; i++) {
            float y = [[self.dictonary valueForKey:[NSString stringWithFormat:@"%d",i%3]]floatValue];
            [self.celleYArray addObject:[NSString stringWithFormat:@"%f",y]];
            [self.dictonary setValue:[NSString stringWithFormat:@"%f",y+[[self.hightArray objectAtIndex:i] intValue]+self.spacingWith] forKey:[NSString stringWithFormat:@"%d",i%3]];
            
            
            
        }
        
        
        
    }
    
    
    
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    NSMutableArray* indexPaths = [[NSMutableArray alloc] init];
    for (int i =0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        [indexPaths addObject:path];
    }
    NSLog(@"%lu",(unsigned long)indexPaths.count);
    for (int i = 0; i<indexPaths.count; i++) {
        
        NSIndexPath *path = [indexPaths objectAtIndex:i];
        [attributes addObject: [self layoutAttributesForItemAtIndexPath:path]];
    }
    
    return attributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = attributes.frame;
    int width = (self.fullWidth -self.spacingWith*(self.columCounts+1))/self.columCounts;
    long x =self.spacingWith+(indexPath.row % self.columCounts)*(self.spacingWith+width);
    frame.size.height = [[self.hightArray objectAtIndex:indexPath.row] integerValue] ;
    frame.size.width = width;
    frame.origin.x = x;
    frame.origin.y = [[self.celleYArray objectAtIndex:indexPath.row] floatValue];
    attributes.frame = frame;
    /**
    float y = [[self.dictonary objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row%self.columCounts]] floatValue] + frame.size.height+self.spacingWith;
    [self.dictonary setValue:[NSString stringWithFormat:@"%f",y] forKey:[NSString stringWithFormat:@"%ld",indexPath.row%self.columCounts]];
    NSLog(@"%f,%f,%f,%f",attributes.frame.origin.x,attributes.frame.origin.y,attributes.frame.size.width,attributes.frame.size.height);
    **/
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    NSLog(@"-------------------%f,%f,%f,%f",newBounds.origin.x,newBounds.origin.y
          ,newBounds.size.width,newBounds.size.height);
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);


}


-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.fullWidth, [[self.celleYArray lastObject] floatValue]+200);

};


@end
