//
//  PostModel.h
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryModel;

@interface PostModel : NSObject

@property (nonatomic , retain) NSString *id90; //model对应的Id
@property (nonatomic , retain) NSString *title; //model对应的title
@property (nonatomic , retain) NSString *description90; //model对应的描述
@property (nonatomic , retain) NSString *publish_time; //model发布时间
@property (nonatomic , retain) NSString *comment_count; //model评论数
@property (nonatomic , retain) NSString *praise_count; //model点赞数
@property (nonatomic , retain) CategoryModel *category;  //model归属分类
@property (nonatomic , retain) NSString *appview; //model详情链接(html)
@property (nonatomic , retain) NSString *imageViewURL; //model对应的图片地址

-(instancetype)initWithDictionary:(NSDictionary *)dic;


@end
