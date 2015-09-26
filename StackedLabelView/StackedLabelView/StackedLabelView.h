//
//  StackedLabelView.h
//  CustomScrollView
//
//  Created by user on 9/25/15.
//  Copyright (c) 2015 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackedLabelView : UIView

@property (nonatomic, strong) NSArray *wordsInScrollView;
@property (nonatomic, strong) NSArray *backgroundColorsOfWords;
@property (nonatomic, strong) UIFont *fontUsedForDisplay;
@property (nonatomic, assign) CGFloat horizontalSpace;

//when change data or frame, need to call this.
- (void) reloadData;

- (NSInteger) currentIndex;

@end
