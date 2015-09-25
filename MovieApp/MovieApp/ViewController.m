//
//  ViewController.m
//  MovieApp
//
//  Created by Abhijith PP on 23/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import "ViewController.h"
#import "MovieCell.h"
#import "MovieDetailViewController.h"
#import "Movie.h"
#import "MBProgressHUD.h"
#import <CoreData/CoreData.h>

static NSString *imageUrl= @"https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=65&h=65";
static NSString *baseUrl=@"http://www.omdbapi.com/?";
static  NSString *detailVcSegueId =@"movieDetailSegue";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self fetchDataFromLocalDB];
    [self.movieListTable reloadData];
    
    
}
#pragma mark - Tableview datasourse methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_moviesArray count];    //count number of row from counting array hear cataGorry is An Array
}

- (MovieCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"MovieCellId";

   MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSManagedObject *movies = [_moviesArray objectAtIndex:indexPath.row];
    Movie *movie=[NSKeyedUnarchiver unarchiveObjectWithData:[movies valueForKey:@"movie"]];
    cell.movieName.text=movie.title;
    
    //Thumb image downlaod
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       UIImage *downloadedImage = [UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:location]];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           if (_moviesArray)
                                                               cell.movieThumbImgView.image=downloadedImage;
                                                       });
                                                   }];

    [downloadPhotoTask resume];

    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.moviesArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        // Remove device from table view
        [self.moviesArray removeObjectAtIndex:indexPath.row];
        [self.movieListTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
#pragma mark - Data fetching methods

-(void)fetchDataForTitle:(NSString *)title
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *dataUrl = [NSString stringWithFormat:@"%@t=%@",baseUrl,title];
    NSURL *url = [NSURL URLWithString:dataUrl];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                      dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          
                                          NSError *e = nil;
                                          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: nil];
                                          
                                          if (!jsonDict) {
                                              NSLog(@"Error parsing JSON: %@", e);
                                          } else {
                                              NSLog(@"Item: %@", jsonDict);

                                              if ([[jsonDict objectForKey:@"Response"] isEqualToString:@"True"])
                                              {
                                                  self.movie=[self createMovieModelDict:jsonDict];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_movie.title)
                                                      {
                                                          [self saveDataToLocalDb];
                                                          
                                                          [self fetchDataFromLocalDB];
                                                          
                                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                      }
                                                      
                                                      
                                                  });
                                              }
                                              else
                                              {
                                              
                                              }

                                          }
                                      }];
    [dataTask resume];
}
#pragma mark - Action methods

-(IBAction)searchAction:(id)sender
{
    if (![_searchField.text isEqualToString:@""])
        [self fetchDataForTitle:_searchField.text];
    else
    {
        [self showAlertWiithTitle:@"Please enter the title" doneButtonName:@"Ok"];

    }
    

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:detailVcSegueId])
    {
        NSIndexPath *path = [self.movieListTable indexPathForSelectedRow];
        [_movieListTable deselectRowAtIndexPath:path animated:YES];
        MovieDetailViewController *moviewDetailVC = [segue destinationViewController];
        NSManagedObject *movies=[_moviesArray objectAtIndex:path.row];
        Movie *movie= [NSKeyedUnarchiver unarchiveObjectWithData:[movies valueForKey:@"movie"]];
        [moviewDetailVC setMovie:movie];

    }
}
#pragma mark - model methods

-(Movie *)createMovieModelDict:(NSDictionary *)dict
{
    Movie *movie=[[Movie alloc] init];
    movie.title=[dict objectForKey:@"Title"];
    movie.year=[dict objectForKey:@"Year"];
    movie.director=[dict objectForKey:@"Director"];
    movie.writer=[dict objectForKey:@"Writer"];
    movie.plot=[dict objectForKey:@"Plot"];
    movie.language=[dict objectForKey:@"Language"];
    movie.country=[dict objectForKey:@"Country"];
    movie.imdbRating=[dict objectForKey:@"imdbRating"];
    movie.imdbVotes=[dict objectForKey:@"imdbVotes"];
    return movie;
}
#pragma mark - Coredata methods

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)saveDataToLocalDb {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (![self isMovieSavedBefore:_movie.title])
    {
        NSManagedObject *movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:_movie];
        [movie setValue:data forKey:@"movie"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}
-(BOOL)isMovieSavedBefore:(NSString *)title
{
    for (NSManagedObject *movies in _moviesArray)
    {
        Movie *movie=[NSKeyedUnarchiver unarchiveObjectWithData:[movies valueForKey:@"movie"]];
        if ([[movie valueForKey:@"title"] isEqualToString:title])
        {
            [self showAlertWiithTitle:@"Movie cached already" doneButtonName:@"OK"];
            return YES;
        }
    }
    return NO;
}
-(void)fetchDataFromLocalDB
{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Movie"];
    self.moviesArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.movieListTable reloadData];
}
#pragma mark - Alertview methods

-(void)showAlertWiithTitle:(NSString *)title doneButtonName:(NSString *)buttonTitle
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:title
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:buttonTitle
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - TextField Delegate methods

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_searchField resignFirstResponder];;
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
