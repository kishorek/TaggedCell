//
//  TaggedCell.h
//  TagListCell Demo
//
//  Created by Kishore Kumar on 16/7/13.
//  Copyright (c) 2013 Kishore Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaggedCellProtocol <NSObject>

@optional
-(void) tagTapped:(NSString *) tag;

@end

@interface TaggedCell : UITableViewCell

/** Array of strings that will be shown as tags */
@property(nonatomic, strong) NSArray *tags;
/** Selected tags */
@property(nonatomic, strong) NSMutableArray *selectedTags;
@property(nonatomic,strong) UIColor *defaultColor;
@property(nonatomic, strong) UIColor *highlightedColor;

@property(nonatomic, weak) id<TaggedCellProtocol> delegate;


+(int) heightForTags:(NSArray *) tags;

@end
