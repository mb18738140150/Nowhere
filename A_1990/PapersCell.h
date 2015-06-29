//
//  PapersCell.h
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PapersCell : UITableViewCell

@property (nonatomic , retain) EGOImageView *bigImageView;

@property (nonatomic , retain) EGOImageView *imageSmallView;

@property (nonatomic , retain) UILabel *titleLabel;

@property (nonatomic , retain) UILabel *descriptionLabel;

@property (nonatomic , retain) UILabel *category;

@property (nonatomic , retain) NSString *url;


@end
