//
//  ViewController.m
//  CustomScrollView
//
//  Created by user on 9/25/15.
//  Copyright (c) 2015 user. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "StackedLabelView.h"

@interface ViewController ()<StackedLabelDelegate>
{
    __weak IBOutlet StackedLabelView *stackedView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(UISegmentedControl*)sender {
    NSMutableArray *stringArray = [NSMutableArray array];
    NSMutableArray *colorArray = [NSMutableArray array];
    NSMutableArray *textColorArray = [NSMutableArray array];
    [NSMutableArray array];
    
    switch (sender.selectedSegmentIndex) {
        case 5:
            [stringArray addObject:@"first"];
            [colorArray addObject:[UIColor redColor]];
            [textColorArray addObject:[UIColor whiteColor]];
        case 4:
            [stringArray addObject:@"secondString"];
            [colorArray addObject:[UIColor yellowColor]];
            [textColorArray addObject:[UIColor darkTextColor]];

        case 3:
            [stringArray addObject:@"fourthStringValuefourthStringValuefourthStringValuefourthStringValue"];
            [colorArray addObject:[UIColor blueColor]];
            [textColorArray addObject:[UIColor yellowColor]];

        case 2:
            [stringArray addObject:@"adf"];
            [colorArray addObject:[UIColor whiteColor]];
            [textColorArray addObject:[UIColor blueColor]];

        case 1:
            [stringArray addObject:@"fifth"];
            [colorArray addObject:[UIColor cyanColor]];
            [textColorArray addObject:[UIColor darkTextColor]];

        case 0:
            [stringArray addObject:@"six"];
            [colorArray addObject:[UIColor grayColor]];
            [textColorArray addObject:[UIColor whiteColor]];

            
        default:
            break;
    }
    
    stackedView.wordsInScrollView = stringArray;
    stackedView.backgroundColorsOfWords = colorArray;
    stackedView.colorOfWords = textColorArray;
    stackedView.fontUsedForDisplay = [UIFont systemFontOfSize:50];
    stackedView.horizontalSpace = 10;
    stackedView.delegate = self;
    [stackedView reloadData];
    
}

- (void)stackedLabel:(StackedLabelView *)stackedLabel changedWithLabel:(NSString *)changedString
{
    NSLog(@"Label changed with %@", changedString);
}

@end
