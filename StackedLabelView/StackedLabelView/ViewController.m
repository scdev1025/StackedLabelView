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

@interface ViewController ()
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
    NSMutableArray *colorArray = @[[UIColor whiteColor],
                                   [UIColor yellowColor],
                                   [UIColor blueColor]];
    
    [NSMutableArray array];
    
    switch (sender.selectedSegmentIndex) {
        case 5:
            [stringArray addObject:@"first"];
            [colorArray addObject:[UIColor redColor]];
        case 4:
            [stringArray addObject:@"secondString"];
            [colorArray addObject:[UIColor yellowColor]];
        case 3:
            [stringArray addObject:@"third"];
            [colorArray addObject:[UIColor blueColor]];
        case 2:
            [stringArray addObject:@"fourthStringValue"];
            [colorArray addObject:[UIColor whiteColor]];
        case 1:
            [stringArray addObject:@"fifth"];
            [colorArray addObject:[UIColor cyanColor]];
        case 0:
            [stringArray addObject:@"six"];
            [colorArray addObject:[UIColor grayColor]];
            
        default:
            break;
    }
    
    stackedView.wordsInScrollView = stringArray;
    stackedView.backgroundColorsOfWords = colorArray;
    stackedView.fontUsedForDisplay = [UIFont systemFontOfSize:50];
    stackedView.horizontalSpace = 10;
    [stackedView reloadData];
    
}


@end
