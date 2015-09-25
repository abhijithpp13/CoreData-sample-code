//
//  Movie.m
//  MovieApp
//
//  Created by Abhijith PP on 24/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import "Movie.h"

@implementation Movie
-(id)initWithCoder:(NSCoder *)aDecoder
{
    //read
    if(self = [super init]){
        _title=[aDecoder decodeObjectForKey:@"title"];
        _year=[aDecoder decodeObjectForKey:@"year"];
        _director=[aDecoder decodeObjectForKey:@"director"];
        _writer=[aDecoder decodeObjectForKey:@"writer"];
        _country=[aDecoder decodeObjectForKey:@"country"];
        _plot=[aDecoder decodeObjectForKey:@"plot"];
        _actors=[aDecoder decodeObjectForKey:@"actors"];
        _language=[aDecoder decodeObjectForKey:@"language"];
        _awards=[aDecoder decodeObjectForKey:@"awards"];
        _imdbRating=[aDecoder decodeObjectForKey:@"imdbRating"];
        _imdbVotes=[aDecoder decodeObjectForKey:@"imdbVotes"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //save
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_year forKey:@"year"];
    [encoder encodeObject:_director forKey:@"director"];
    [encoder encodeObject:_writer forKey:@"writer"];
    [encoder encodeObject:_country forKey:@"country"];
    [encoder encodeObject:_plot forKey:@"plot"];
    [encoder encodeObject:_actors forKey:@"actors"];
    [encoder encodeObject:_language forKey:@"language"];
    [encoder encodeObject:_awards forKey:@"awards"];
    [encoder encodeObject:_imdbRating forKey:@"imdbRating"];
    [encoder encodeObject:_imdbVotes forKey:@"imdbVotes"];
}
@end
