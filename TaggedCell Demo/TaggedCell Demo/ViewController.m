//
//  ViewController.m
//  TaggedCell Demo
//
//  Created by Kishore Kumar on 16/7/13.
//  Copyright (c) 2013 Kishore Kumar. All rights reserved.
//

#import "ViewController.h"
#import "TaggedCell.h"

@interface ViewController ()
@property(nonatomic, strong) NSArray *tags1;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tags1 = @[@"Cheetah",@"Puma",@"Jaguar",@"Panther",@"Tiger",@"Leopard",@"Snow Leopard",@"Lion",@"Mountain Lion", @"Mavericks"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"TaggedCell";
    
    TaggedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[TaggedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.tags = self.tags1;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TaggedCell heightForTags:self.tags1];
}

@end
