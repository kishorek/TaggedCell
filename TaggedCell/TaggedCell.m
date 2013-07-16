//
//  TaggedCell.m
//  TagListCell Demo
//
//  Created by Kishore Kumar on 16/7/13.
//  Copyright (c) 2013 Kishore Kumar. All rights reserved.
//

#import "TaggedCell.h"
#import <QuartzCore/QuartzCore.h>

#define kReuseId @"TaggedCell"
#define kCellFont [UIFont systemFontOfSize:15.0f]
#define kTagButtonPadding 5
#define kTagButtonHeight 25
#define kCellLeftPadding 10
#define kCellRightPadding 10
#define kCellTopPadding 10
#define kSpaceBetweenTags 16

@interface TaggedCell ()
@property(nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation TaggedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!self.selectedTags) {
            self.selectedTags = [[NSMutableArray alloc] init];
        }
        self.tagButtons = [[NSMutableArray alloc] init];
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - Custom methods
-(void)setTags:(NSArray *)tags{
    _tags = tags;
    [self renderTagsList];
}

-(void) setSelectedTags:(NSMutableArray *)selectedTags{
    _selectedTags = selectedTags;
    [self renderTagsList];
}

-(void) renderTagsList{
    
    //Clear the previous buttons
    for (UIButton *tagBtn in self.tagButtons) {
        [tagBtn removeFromSuperview];
    }
    
    int x=kCellLeftPadding;
    int y=kCellTopPadding;
    int displayWidth = [[UIScreen mainScreen] bounds].size.width;
    int calculatedWidth = displayWidth-(kCellLeftPadding+kCellRightPadding);
    
    for (int i=0;i<self.tags.count;i++) {
        NSString *currentTag = self.tags[i];
        
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tagButton.layer.cornerRadius = 5.0;
        tagButton.layer.borderColor = [UIColor grayColor].CGColor;
        tagButton.layer.borderWidth = 1.0;
        tagButton.titleLabel.font = kCellFont;
        
        [tagButton setTitle:currentTag forState:UIControlStateNormal];
        [tagButton addTarget:self action:@selector(tagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize tagButtonSize = [currentTag sizeWithFont:kCellFont];
        //TODO: Fix for large tag texts 
//        if (tagButtonSize.width>displayWidth) {
//            tagButton.titleLabel.numberOfLines = 3;
//            tagButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        }
        [tagButton setFrame:CGRectMake(x, y, tagButtonSize.width+kTagButtonPadding, kTagButtonHeight)];
        
        //Next tag width
        CGSize nextButtonSize = CGSizeZero;
        if (i<(self.tags.count-1)) {
            NSString *nextTag = self.tags[i+1];
            nextButtonSize = [nextTag sizeWithFont:kCellFont];
        }
        x+=tagButtonSize.width+kSpaceBetweenTags;
        if (x>calculatedWidth || (x+nextButtonSize.width>calculatedWidth)) {
            x = kCellLeftPadding;
            y += (kTagButtonHeight+kTagButtonPadding);
        }
        
        [self chooseButtonSelectionStyle:tagButton];
        [self.tagButtons addObject:tagButton];
        [self.contentView addSubview:tagButton];
    }
}

-(void) tagButtonTapped:(id) sender{
    UIButton *button = (UIButton *)sender;
    NSString *title = button.titleLabel.text;
    
    if ([self.selectedTags containsObject:title]) {
        [self.selectedTags removeObject:title];
        [self setTagButtonUnSelected:button];
    } else {
        [self.selectedTags addObject:title];
        [self setTagButtonSelected:button];
    }
    
    if ([self.delegate respondsToSelector:@selector(tagTapped:)]) {
        [self.delegate tagTapped:title];
    }
}

-(void) chooseButtonSelectionStyle:(UIButton *) tagButton{
    if ([self.selectedTags containsObject:tagButton.titleLabel.text]) {
        [self setTagButtonSelected:tagButton];
    } else {
        [self setTagButtonUnSelected:tagButton];
    }
}

-(void) setTagButtonSelected:(UIButton *) tagButton{
    tagButton.backgroundColor = self.highlightedColor?self.highlightedColor:[UIColor purpleColor];
    [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void) setTagButtonUnSelected:(UIButton *) tagButton{
    tagButton.backgroundColor = self.defaultColor?self.defaultColor:[UIColor whiteColor];
    [tagButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

+(int) heightForTags:(NSArray *) tags{
    int x=kCellLeftPadding;
    int y=kCellTopPadding;
    int displayWidth = [[UIScreen mainScreen] bounds].size.width;
    int calculatedWidth = displayWidth-(kCellLeftPadding+kCellRightPadding);

    for (int i=0;i<tags.count;i++) {
        NSString *currentTag = tags[i];
        CGSize tagButtonSize = [currentTag sizeWithFont:kCellFont];
        
        //Next tag width
        CGSize nextButtonSize = CGSizeZero;
        if (i<(tags.count-1)) {
            NSString *nextTag = tags[i+1];
            nextButtonSize = [nextTag sizeWithFont:kCellFont];
        }
        
        x+=tagButtonSize.width+kSpaceBetweenTags;
        if (x>calculatedWidth || (x+nextButtonSize.width>calculatedWidth)) {
            x = kCellLeftPadding;
            y += (kTagButtonHeight+kTagButtonPadding);
        }
    }
    return y+50;
}

@end
