//
//  StackedLabelView.m
//  CustomScrollView
//
//  Created by ken on 9/25/15.
//  Copyright (c) 2015 user. All rights reserved.
//

#import "StackedLabelView.h"

typedef NS_ENUM(int, ScrollState) {
    ScrollingStop = 0,
    ScrollingLeft = -1,
    ScrollingRight = 1
};

@interface StackedLabelView()<UIScrollViewDelegate>
{
    UIScrollView *labelScrollView;
    UIView *maskView;
    NSInteger _currentIndex;
    ScrollState scrollState;
    
    UILabel *previousLabel;
    UILabel *currentLabel;
    UILabel *currentFlowLabel;
    UILabel *nextLabel;
}

@end

@implementation StackedLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self createSubViews];
    }
    return self;
}


- (void) createSubViews {
    // Create maskview;
    maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.clipsToBounds = true;
    maskView.layer.cornerRadius = 4;
    maskView.layer.masksToBounds = YES;
    [self addSubview:maskView];
    
    //add previous, static current label
    
    previousLabel = [[UILabel alloc] init];
    previousLabel.hidden = true;
    currentLabel = [[UILabel alloc] init];
    currentLabel.hidden = true;
    [maskView addSubview:previousLabel];
    [maskView addSubview:currentLabel];
    
    // add scrollview to show label
    labelScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [labelScrollView setPagingEnabled:YES];
    [labelScrollView setClipsToBounds:false];
    labelScrollView.delegate = self;
    [maskView addSubview:labelScrollView];
    
    // add movable current label and next label
    currentFlowLabel = [[UILabel alloc] init];
    nextLabel = [[UILabel alloc] init];
    currentFlowLabel.hidden = true;
    nextLabel.hidden = true;
    [labelScrollView addSubview:currentFlowLabel];
    [labelScrollView addSubview:nextLabel];
    
    //hide labelScrollView;
    [labelScrollView setShowsHorizontalScrollIndicator:false];
   
    previousLabel.textColor = [self textColorAtIndex:_currentIndex - 1];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    nextLabel.textColor = [self textColorAtIndex:_currentIndex + 1];//[UIColor whiteColor];

    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void) dealloc {
    [labelScrollView removeObserver:self
                    forKeyPath:@"contentOffset"];
}

#pragma mark stacked label functions

- (void)reloadData
{
    _currentIndex = 0;
    [self buildSubViewsForScrolling];
    
    CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(16.0f, 0.0f, 0.0f) ],
                     [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-16.0f, 0.0f, 0.0f) ],
                     [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f) ],
                     ] ;
    anim.autoreverses = NO ;
    anim.repeatCount = 0.0f ;
    anim.duration = 0.40f ;
    [labelScrollView.layer addAnimation:anim forKey:nil ];
}

- (NSInteger) currentIndex {
    return _currentIndex;
}

- (void) buildSubViewsForScrolling{
    
    if (self.wordsInScrollView == nil || self.wordsInScrollView.count == 0 ) {
        previousLabel.hidden = true;
        currentFlowLabel.hidden = true;
        currentLabel.hidden = true;
        nextLabel.hidden = true;
        return;
    }
    [labelScrollView setContentOffset:CGPointZero animated:NO];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    CGSize contentSize = CGSizeZero;
    
    
    // currentlabel //this sets the colors and strings
    [self setLabel:currentLabel withString:[self stringAtIndex:_currentIndex] andBackgroundColor:[self backgroundColorAtIndex:_currentIndex] withTextColor:[self textColorAtIndex:_currentIndex]];
    [self setLabel:currentFlowLabel withString:[self stringAtIndex:_currentIndex] andBackgroundColor:[self backgroundColorAtIndex:_currentIndex] withTextColor:[self textColorAtIndex:_currentIndex]];
    currentFlowLabel.hidden = false;
    
    // previousLabel
    if (_currentIndex == 0) {
        previousLabel.text = @"";
        previousLabel.backgroundColor = [UIColor clearColor];
    }else{
        [self setLabel:previousLabel withString:[self stringAtIndex:_currentIndex - 1] andBackgroundColor:[self backgroundColorAtIndex:_currentIndex - 1] withTextColor:[self textColorAtIndex:_currentIndex - 1]];
        edgeInsets.left = previousLabel.bounds.size.width;
        contentSize.width = previousLabel.bounds.size.width;
    }
    
    if (_currentIndex < self.wordsInScrollView.count - 1) {
        [self setLabel:nextLabel withString:[self stringAtIndex:_currentIndex + 1] andBackgroundColor:[self backgroundColorAtIndex:_currentIndex + 1] withTextColor:[self textColorAtIndex:_currentIndex + 1]];
        if (contentSize.width < currentFlowLabel.bounds.size.width) {
            contentSize.width = currentFlowLabel.bounds.size.width;
            edgeInsets.right = currentFlowLabel.bounds.size.width;
        }else{
            edgeInsets.right = currentFlowLabel.bounds.size.width;
        }
        nextLabel.hidden = false;
    }else{
        nextLabel.text = @"";
        nextLabel.backgroundColor = [UIColor clearColor];
    }
    
    CGRect nextframe = nextLabel.bounds;
    nextframe.origin.x = currentFlowLabel.bounds.size.width;
    nextLabel.frame = nextframe;
    
    [labelScrollView setFrame:CGRectMake(0, 0, contentSize.width, self.frame.size.height)];
    [labelScrollView setContentSize:contentSize];
    [labelScrollView setContentInset:edgeInsets];
    
    //set mask size
    maskView.frame = CGRectMake(0, 0, currentLabel.bounds.size.width - 1, self.frame.size.height);
    
    previousLabel.textColor = [self textColorAtIndex:_currentIndex - 1];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    nextLabel.textColor = [self textColorAtIndex:_currentIndex + 1];//[UIColor whiteColor];
}

- (NSString*) stringAtIndex:(NSInteger) index
{
    if (index >= 0 && index < self.wordsInScrollView.count) {
        return self.wordsInScrollView[index];
    }else{
        return @"";
    }
}

- (UIColor*) backgroundColorAtIndex:(NSInteger) index
{
    if (index >= 0 && index < self.backgroundColorsOfWords.count) {
        return self.backgroundColorsOfWords[index];
    }
    return [UIColor whiteColor];
}

- (UIColor*) textColorAtIndex:(NSInteger) index
{
    if (index >= 0 && index < self.colorOfWords.count) {
        return self.colorOfWords[index];
    }
    return [UIColor darkTextColor];
}

- (void) setLabel:(UILabel*) label withString:(NSString*) string andBackgroundColor:(UIColor*) color withTextColor:(UIColor*) textColor
{
    UIFont *font = (self.fontUsedForDisplay?self.fontUsedForDisplay:[UIFont systemFontOfSize:20]);
    label.text = string;
    if (color) {
        label.backgroundColor = color;
    }else{
        label.backgroundColor = [UIColor whiteColor];
    }
    if (textColor) {
        label.textColor = textColor;
    }else{
        label.textColor = [UIColor darkTextColor];
    }
    [label setFont:font];
    [label setLineBreakMode:NSLineBreakByClipping];
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    [label setTextAlignment:NSTextAlignmentCenter];
    CGFloat width = size.width + self.horizontalSpace * 2;
    width = MIN(width, self.bounds.size.width);
    [label setFrame:CGRectMake(0, 0, width, self.bounds.size.height)];
    return;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging == false && scrollView.isDecelerating == false) {
        [labelScrollView setContentOffset:CGPointZero animated:NO];
    }
    
    if (scrollView.contentOffset.x > 0) {
        if (currentLabel.frame.size.width == 0) {
            return;
        }
        currentFlowLabel.hidden = true;
        currentLabel.hidden = false;
        previousLabel.hidden = true;
        
        CGFloat width = currentLabel.frame.size.width - (currentLabel.frame.size.width - nextLabel.frame.size.width) * scrollView.contentOffset.x / currentLabel.frame.size.width;
        width = MAX(width,
                    MIN(currentLabel.frame.size.width, nextLabel.frame.size.width));
        maskView.frame = CGRectMake(0, 0, width, self.frame.size.height);
    }else{
        if (previousLabel.frame.size.width == 0) {
            return;
        }
        previousLabel.hidden = false;
        currentLabel.hidden = true;
        currentFlowLabel.hidden = false;
        
        CGFloat width = currentLabel.frame.size.width + (currentLabel.frame.size.width - previousLabel.frame.size.width) * scrollView.contentOffset.x / previousLabel.frame.size.width;
        width = MAX(width,
                    MIN(currentLabel.frame.size.width, previousLabel.frame.size.width));
        maskView.frame = CGRectMake(0, 0, width, self.frame.size.height);
    }
    
    previousLabel.textColor = [self textColorAtIndex:_currentIndex - 1];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    nextLabel.textColor = [self textColorAtIndex:_currentIndex + 1];//[UIColor whiteColor];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        if (scrollView.contentInset.left != 0 && -labelScrollView.contentOffset.x > scrollView.contentInset.left) {
            [scrollView setPagingEnabled:false];
            [scrollView setContentOffset:CGPointMake(-scrollView.contentInset.left, 0) animated:YES];
            maskView.frame = CGRectMake(0, 0, scrollView.contentInset.left, self.frame.size.height);
            
        }else if (scrollView.contentInset.right != 0 && labelScrollView.contentOffset.x > scrollView.contentInset.right) {
            [scrollView setPagingEnabled:false];
            [scrollView setContentOffset:CGPointMake(scrollView.contentInset.right, 0) animated:YES];
            maskView.frame = CGRectMake(0, 0, scrollView.contentInset.right, self.frame.size.height);
        }
    }else{
        if (scrollView.contentOffset.x > 0) {
            _currentIndex++;
            [self buildSubViewsForScrolling];
            if (self.delegate) {
                [self.delegate stackedLabel:self changedWithLabel:[self stringAtIndex:_currentIndex]];
            }
        }else if (scrollView.contentOffset.x < 0){
            _currentIndex--;
            [self buildSubViewsForScrolling];
            if (self.delegate) {
                [self.delegate stackedLabel:self changedWithLabel:[self stringAtIndex:_currentIndex]];
            }
        }
        [scrollView setPagingEnabled:true];
    }
    
    previousLabel.textColor = [self textColorAtIndex:_currentIndex - 1];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    currentFlowLabel.textColor = [self textColorAtIndex:_currentIndex];//[UIColor whiteColor];
    nextLabel.textColor = [self textColorAtIndex:_currentIndex + 1];//[UIColor whiteColor];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self buildSubViewsForScrolling];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0 && _currentIndex < self.wordsInScrollView.count - 1) {
        _currentIndex++;
        [self buildSubViewsForScrolling];
        if (self.delegate) {
            [self.delegate stackedLabel:self changedWithLabel:[self stringAtIndex:_currentIndex]];
        }
    }else if (scrollView.contentOffset.x < 0 && _currentIndex >= 0){
        _currentIndex--;
        [self buildSubViewsForScrolling];
        if (self.delegate) {
            [self.delegate stackedLabel:self changedWithLabel:[self stringAtIndex:_currentIndex]];
        }
    }
    
    [scrollView setPagingEnabled:true];
}
@end
