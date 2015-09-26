# StackedLabelView
This is StackView for UILabel.

![First Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/image1.png)![Second Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/image2.png)![Third Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/image3.png)![Fourth Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/image4.png)

## How to use
    NSArray *stringArray = @[@"first", @"second", @"third"];
    NSArray *colorArray = @[[UIColor whiteColor],
                                   [UIColor yellowColor],
                                   [UIColor blueColor]];
    stackedView.wordsInScrollView = stringArray;
    stackedView.backgroundColorsOfWords = colorArray;
    stackedView.fontUsedForDisplay = [UIFont systemFontOfSize:30];
    stackedView.horizontalSpace = 10;
    [stackedView reloadData];
