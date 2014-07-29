//
//  ItemCell.m
//  daily Expenses
//
//  Created by renan veloso silva on 18/05/13.
//  Copyright (c) 2013 renan veloso silva. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

@synthesize itemModel;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
 
    }
    return self;
}

-(void)setItemModel:(ItemModel *)_itemModel{
    self.label.text = _itemModel.label;
    self.price.text = _itemModel.value;
    self.icon.image = [UIImage imageNamed:_itemModel.category.imageName];
    
    UIColor *typeColor = _itemModel.isMoneyIn ? [UIColor greenColor] : [UIColor redColor];
    [self.typeView setBackgroundColor:typeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_typeView release];
    [super dealloc];
}
@end
