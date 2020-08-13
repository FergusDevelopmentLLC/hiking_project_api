Project Deliverables

1. A link to your project repo, with code for your Rails backend and HTML / CSS / JavaScript frontend.  
Front end: https://github.com/FergusDevelopmentLLC/hiking_project_fe  
Back end: https://github.com/FergusDevelopmentLLC/hiking_project_api

2. A README.md file describing your application  
Front end: https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/README.md  
Back end: https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/README.md

3. A Blog Post about your application  
https://medium.com/@will.carter/reviving-old-ideas-2f2908189a34

4. A 2-4 minute Video Demo introducing your application  
Coming soon

5. The application must be an HTML, CSS, and JavaScript frontend with a Rails API backend.  
It is.

6. All interactions between the client and the server must be handled asynchronously (AJAX) and use JSON as the communication format.  
They are.

7. The JavaScript application must use Object Oriented JavaScript (classes) to encapsulate related data and behavior.  
The front end has a Trail class, see https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/trail.js.  
In order to populate the front end map when the data is returned, Trail objects are instantiated, populated and put into a global array called trailsArray.  
This happens when a user searches by lat/lng:  
Line 258 in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/custom.js  
...and when they search by city, state:  
Line 116 in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/autocomplete.js

8. The domain model served by the Rails backend must include a resource with at least one has-many relationship.  
In Hikefinder, a city model has and belongs to many Trail models. (many to many relationship)  
See the back end city class here: https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/app/models/city.rb  
And, the parent child relationship is enforced in: https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/config/routes.rb

9. The backend and frontend must collaborate to demonstrate Client-Server Communication. Your application should have at least 3 AJAX calls, covering at least 2 of Create, Read, Update, and Delete (CRUD).  
When the user searches by latitude/longitude (Read):  
See front end read method, displayTrailsByLatLng:  
Line 249 in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/custom.js  
When the user searches by City, Sate (Read).  
See front end method, populate:  
Line 105 in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/autocomplete.js  
When the user clicks on a trail or the trail name link and goes to the Hiking project detail (Update)  
See PATCH CRUD update front end method:  
Line 86 in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/index.html

10. Your client-side JavaScript code must use fetch with the appropriate HTTP verb, and your Rails API should use RESTful conventions.  
The 2 reads use GET requests, and the update uses the PATCH verb.  
See the PATCH update at line 86 in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/index.html

11. JavaScript: Use classes and functions to organize your code into reusable pieces.  
All the functions in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/custom.js were written by me. Many functions are called from different places, exhibiting code reuse.

12. JavaScript: Translate JSON responses into JavaScript model objects using ES6 class or constructor function syntax.  
See getTrailObjectsFrom (mapData) function in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/custom.js  
... and the Trail class: https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/trail.js 

13. JavaScript: Use ES6 features when appropriate (e.g. arrow functions, let & const, rest and spread syntax).  
All of the functions in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/custom.js are arrow functions.  
Use of let is frequent in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/js/custom.js  
Use of const is in https://github.com/FergusDevelopmentLLC/hiking_project_fe/blob/master/public/index.html, line 67  
I did not use rest nor spread syntax.

14. Rails: Follow Rails MVC and RESTful conventions  
I did. See the following controllers.  
https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/app/controllers/trails_controller.rb  
https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/app/controllers/cities_controller.rb  
https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/app/controllers/cities_trails_controller.rb

15. Well-named variables and methods  
I did this.

16. Short, single-purpose methods  
Yes, my longest method is the for_city method in https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/app/controllers/trails_controller.rb. It has 21 lines of code, but could be refactored/shortened.

17. Git: Aim for a large number of small commits - commit frequently!  
The API has 94 commits currenty.  
The front end has 74 commits currently.

18. Add meaningful messages to your commits. When you look back at your commits with git log, the messages should describe each change.  
I made sure of this.

19. Don't include changes in a commit that aren't related to the commit message  
I did not do this.