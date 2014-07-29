//
//  ItemCell.h
//  daily Expenses
//
//  Created by renan veloso silva on 18/05/13.
//  Copyright (c) 2013 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"


@interface ItemCell : UITableViewCell{
    ItemModel *itemModel;
}

@property (assign) IBOutlet UILabel *price;
@property (assign) IBOutlet UILabel *label;
@property (assign) IBOutlet UIImageView *icon;
@property (retain, nonatomic) IBOutlet UIView *typeView;

@property (nonatomic, assign) ItemModel *itemModel;

@end
