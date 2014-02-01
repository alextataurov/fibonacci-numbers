//
//  ViewController.m
//  Fibonacci numbers
//
//  Created by Alex Tataurov on 01/02/14.
//  Copyright (c) 2014 Alex Tataurov. All rights reserved.
//

#import "ViewController.h"

NSUInteger const static fibbonaciNumbersLimit = 100;

@interface ViewController ()

@end

@implementation ViewController {
    NSMutableArray *_fibbonaciNumbers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _fibbonaciNumbers = [NSMutableArray arrayWithCapacity:fibbonaciNumbersLimit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getting Fibonnaci numbers

- (unsigned long long)getFibbonaci:(NSUInteger)order
{
    if (_fibbonaciNumbers.count > order && _fibbonaciNumbers[order] != nil) {
        return [_fibbonaciNumbers[order] unsignedLongLongValue];
    }
    
    if (order < 3) {
        _fibbonaciNumbers[order] = @1;
        return 1;
    }
    
    unsigned long long previousNumber;
    if (_fibbonaciNumbers.count > order && _fibbonaciNumbers[order - 1] != nil) {
        previousNumber = [_fibbonaciNumbers[order - 1] unsignedLongLongValue];
    }
    else {
        previousNumber = [self getFibbonaci:(order - 1)];
        _fibbonaciNumbers[order - 1] = [NSNumber numberWithUnsignedLongLong:previousNumber];
    }
    
    unsigned long long previous2Number;
    if (_fibbonaciNumbers.count > (order - 1) && _fibbonaciNumbers[order - 2] != nil) {
        previous2Number = [_fibbonaciNumbers[order - 2] unsignedLongLongValue];
    }
    else {
        previous2Number = [self getFibbonaci:(order - 1)];
        _fibbonaciNumbers[order - 2] = [NSNumber numberWithUnsignedLongLong:previous2Number];
    }
    
    return previousNumber + previous2Number;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return fibbonaciNumbersLimit;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        unsigned long long fibbonaciNumber = [self getFibbonaci:indexPath.row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.textLabel.text = [NSString stringWithFormat:@"%llu", fibbonaciNumber];
            [cell setNeedsLayout];
        });
    });
    
    return cell;
}

@end
