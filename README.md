# StackedLabelView
This is StackView for UILabel.

![First Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/iOS%20Simulator%20Screen%20Shot%20Sep%2026%2C%202015%2C%203.45.21%20PM.png)![Second Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/iOS%20Simulator%20Screen%20Shot%20Sep%2026%2C%202015%2C%203.45.11%20PM.png)![Third Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/iOS%20Simulator%20Screen%20Shot%20Sep%2026%2C%202015%2C%203.45.18%20PM.png)![Fourth Image](https://github.com/kenneth1025/StackedLabelView/blob/master/StackedLabelView/screenshots/iOS%20Simulator%20Screen%20Shot%20Sep%2026%2C%202015%2C%203.45.13%20PM.png)

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
