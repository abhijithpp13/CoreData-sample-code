//
//  MovieCell.h
//  MovieApp
//
//  Created by Abhijith PP on 23/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView *movieThumbImgView;
@property(nonatomic,weak)IBOutlet UILabel *movieName;

@end
