//
//  Movie.h
//  MovieApp
//
//  Created by Abhijith PP on 24/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *year;
@property(nonatomic,strong) NSString *rated;
@property(nonatomic,strong) NSString *releaseDate;
@property(nonatomic,strong) NSString *runTime;
@property(nonatomic,strong) NSString *genre;
@property(nonatomic,strong) NSString *director;
@property(nonatomic,strong) NSString *writer;
@property(nonatomic,strong) NSString *actors;
@property(nonatomic,strong) NSString *plot;
@property(nonatomic,strong) NSString *language;
@property(nonatomic,strong) NSString *country;
@property(nonatomic,strong) NSString *awards;
@property(nonatomic,strong) NSString *poster;
@property(nonatomic,strong) NSString *metascore;
@property(nonatomic,strong) NSString *imdbRating;
@property(nonatomic,strong) NSString *imdbVotes;
@property(nonatomic,strong) NSString *imdbId;
@property(nonatomic,strong) NSString *type;
@end
