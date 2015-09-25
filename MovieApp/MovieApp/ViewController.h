//
//  ViewController.h
//  MovieApp
//
//  Created by Abhijith PP on 23/09/15.
//  Copyright © 2015 Abhijtih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Movie.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView *movieListTable;
@property(nonatomic,weak)IBOutlet UITextField *searchField;

@property(nonatomic,strong)NSDictionary *moviewDict;
@property (strong) NSMutableArray *moviesArray;
@property (strong) NSManagedObject *moviesObject;

@property(nonatomic,strong)Movie *movie;

@end

