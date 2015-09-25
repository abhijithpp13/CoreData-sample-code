//
//  MovieDetailViewController.m
//  MovieApp
//
//  Created by Abhijith PP on 23/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.movieTitle.text=_movie.title;
    self.yearPub.text=[NSString stringWithFormat:@"Year : %@",_movie.year];
    self.directorName.text=[NSString stringWithFormat:@"Director : %@",_movie.director];
    self.writer.text=[NSString stringWithFormat:@"Writer : %@",_movie.writer];
    self.plot.text=[NSString stringWithFormat:@"Plot : %@",_movie.plot];
    self.language.text=[NSString stringWithFormat:@"Language : %@",_movie.language];
    self.Country.text=[NSString stringWithFormat:@"Country : %@",_movie.country];
    self.imdbRating.text=[NSString stringWithFormat:@"IMDB Rating : %@",_movie.imdbRating];
    self.imdbVotes.text=[NSString stringWithFormat:@"IMDB Votes : %@",_movie.imdbVotes];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
