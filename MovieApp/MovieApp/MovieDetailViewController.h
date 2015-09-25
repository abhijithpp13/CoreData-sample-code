//
//  MovieDetailViewController.h
//  MovieApp
//
//  Created by Abhijith PP on 23/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController
@property(nonatomic,strong)Movie *movie;
@property (nonatomic,weak)IBOutlet UILabel *movieTitle;
@property (nonatomic,weak)IBOutlet UILabel *yearPub;
@property (nonatomic,weak)IBOutlet UILabel *directorName;
@property (nonatomic,weak)IBOutlet UILabel *language;
@property (nonatomic,weak)IBOutlet UILabel *writer;
@property (nonatomic,weak)IBOutlet UILabel *plot;
@property (nonatomic,weak)IBOutlet UILabel *Country;
@property (nonatomic,weak)IBOutlet UILabel *awards;
@property (nonatomic,weak)IBOutlet UILabel *imdbRating;
@property (nonatomic,weak)IBOutlet UILabel *imdbVotes;
@end
