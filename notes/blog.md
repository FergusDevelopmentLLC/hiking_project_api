https://guides.rubyonrails.org/api_app.html

https://rollout.io/blog/building-a-json-api-with-rails-5/

Here I was looking at how you generate a Ruby on Rails API only application. There is a series of generate statements that basically created the backend.

```
rails generate scaffold Trail hiking_project_id:integer name:string trail_type:string summary:string difficulty:string stars:float starVotes:integer location:string url:string imgSqSmall:string imgSmall:string imgSmallMed:string imgMedium:string length:float ascent:integer descent:integer high:integer low:integer longitude:float latitude:float conditionStatus:string conditionDetails:string conditionDate:date features:string overview:string description:string
rails generate scaffold City name:string state:string country:string latitude:float longitude:float timezone:string population:integer
rails generate scaffold CitiesTrail city_id:integer trail_id:integer
rails generate migration AddDistanceToCitiesTrails distance:float
```

---

https://www.hikingproject.com/data

This is the ultimate source of the data for hikefinder.net. The backend api https://github.com/FergusDevelopmentLLC/hiking_project_api for this app is a hybrid that calls the Hiking Project Data API under some circumstances and queries a local postgres database containing trail and city information.

---

https://www.hikingproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10&key=200678194-2bc7d6bf1038d082a1d8e2ab00b617ca

Here is an example call to the api and what a return result consisting of trails looks like:

https://res.cloudinary.com/fergusdev/image/upload/v1596492837/hikefinder/blog%20images/hiking_project_raw_oyk7oo.png

---
http://hikefinder.net:3000/trails/41.95/-87.63/5/15

The api has endpoints with decimals in them. I used the technique described in routes.rb

https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/config/routes.rb


```
# this goes to the api
get 'trails/:latitude/:longitude/:max_distance/:max_results', to: 'trails#for_coords', constraints: { 
  :latitude => /[^\/]+/, 
  :longitude => /[^\/]+/,
  :max_distance => /[^\/]+/,
  :max_results => /[^\/]+/,
}
```
The following links helped me to work this out and make a route containing . work correctly.
http://uchinoinu.hatenablog.jp/entry/2016/09/14/230051

https://stackoverflow.com/questions/59116050/rails-routing-error-with-get-locations-around-17-28794-16-9

https://stackoverflow.com/questions/2648727/rails-pretty-url-with-decimals

---

https://stackoverflow.com/questions/47577532/why-pguniqueviolation-error-duplicate-key-value-violates-unique-constraint?rq=1

I have come across this error a few times with postgres. The fix is to go to the rails console and execute:

```
ActiveRecord::Base.connection.tables.each do |table_name| 
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end
```

This resets all the primary keys in your tables.

---
https://www.w3schools.com/sql/sql_select_into.asp
https://stackoverflow.com/questions/15508948/create-a-new-table-and-adding-a-primary-key-using-select-into

These links explain about how to populate tables. I had a starting table of places sourced from here:

https://hub.arcgis.com/datasets/esri::usa-census-populated-places

---
https://guides.rubyonrails.org/association_basics.html#the-has-and-belongs-to-many-association
https://medium.com/@spaquet/testing-rails-5-api-with-postman-36f1e79dc4d
https://stackoverflow.com/questions/7098732/how-to-add-a-delay-to-rails-controller-for-testing
https://apidock.com/rails/v4.0.2/ActiveRecord/Relation/find_or_create_by
https://apidock.com/ruby/Enumerator/each_with_index
https://stackoverflow.com/questions/13173618/truncate-tables-with-rails-console
https://github.com/jnunemaker/httparty
https://www.postman.com/downloads/
https://medium.com/@hartaniyassir/creating-slug-urls-in-rails-without-gems-c693e0eeec8a
https://alvinalexander.com/blog/post/ruby/how-process-line-text-file-ruby/
https://stackoverflow.com/questions/1188893/is-there-a-way-in-ruby-rails-to-execute-code-that-is-in-a-string
https://stackoverflow.com/questions/34727605/heroku-cannot-run-more-than-1-free-size-dynos
https://gist.github.com/zulhfreelancer/ea140d8ef9292fa9165e
https://apidock.com/rails/ActiveRecord/QueryMethods/where
https://stackoverflow.com/questions/2220423/case-insensitive-search-in-rails-model
https://abbreviations.yourdictionary.com/articles/state-abbrev.html
https://medium.com/@hartaniyassir/creating-slug-urls-in-rails-without-gems-c693e0eeec8a
https://github.com/tonytonyjan/geodesics
https://mashable.com/2013/07/11/lorem-ipsum/
https://dashboard.heroku.com/apps/hiking-project-api/settings
https://www.digitalocean.com/community/tutorials/how-to-set-up-ruby-on-rails-with-postgres
https://dba.stackexchange.com/questions/83164/postgresql-remove-password-requirement-for-user-postgres
https://stackoverflow.com/questions/2748607/how-to-thoroughly-purge-and-reinstall-postgresql-on-ubuntu
https://www.postgresql.org/download/linux/ubuntu/
https://stackoverflow.com/questions/4328679/how-to-configure-postgresql-so-it-accepts-loginpassword-auth
https://www.postgresql.org/docs/8.1/user-manag.html
https://www.reddit.com/r/rails/comments/71by4m/help_the_asset_applicationcss_is_not_present_in/
https://chartio.com/resources/tutorials/how-to-view-which-postgres-version-is-running/
https://stackoverflow.com/questions/40511333/how-do-i-upgrade-my-activesupport-gem
https://stackoverflow.com/questions/23963018/rvm-is-not-a-function-selecting-rubies-with-rvm-use-will-not-work
https://rvm.io/workflow/examples
https://help.learn.co/en/articles/2789231-how-to-upgrade-from-ruby-2-3-to-2-6
https://www.postgresql.org/docs/8.1/user-manag.html
https://www.postgresql.org/message-id/20000911100931.A5469@mindspring.com
https://stackoverflow.com/questions/50102639/running-a-rails-server-in-production-locally-invalidmessage-error
https://til.hashrocket.com/posts/8b8b4d00a3-generate-a-rails-secret-key
https://www.postgresqltutorial.com/postgresql-show-tables/
https://stackoverflow.com/questions/3949876/how-to-switch-databases-in-psql
https://www.postgresqltutorial.com/postgresql-show-databases/
https://dba.stackexchange.com/questions/58312/how-to-get-the-name-of-the-current-database-from-within-postgresql
https://www.postgresql.org/docs/9.4/backup-dump.html
https://dashboard.heroku.com/apps/hiking-project-api/settings
https://hub.arcgis.com/datasets/esri::usa-census-populated-places
https://postgis.net/docs/ST_Centroid.html
https://hub.arcgis.com/datasets/esri::usa-census-populated-places
https://hub.arcgis.com/datasets/esri::usa-census-populated-places
https://stackoverflow.com/questions/18950951/cast-string-to-number-interpreting-null-or-empty-string-as-0
https://stackoverflow.com/questions/20043231/how-to-define-the-type-int-for-a-new-field-in-sql-select-into-statement-in-ms
https://www.postgresql.org/docs/9.1/sql-selectinto.html
https://postgis.net/docs/ST_X.html
https://postgis.net/docs/ST_Y.html
https://postgis.net/docs/ST_Centroid.html
https://dba.stackexchange.com/questions/2973/how-to-insert-values-into-a-table-from-a-select-query-in-postgresql
https://stackoverflow.com/questions/2686254/how-to-select-all-records-from-one-table-that-do-not-exist-in-another-table
https://stackoverflow.com/questions/11317662/rails-using-greater-than-less-than-with-a-where-statement
https://guides.rubyonrails.org/active_record_querying.html
https://stackoverflow.com/questions/2316475/how-do-i-return-early-from-a-rake-task
https://www.rubyguides.com/2015/05/working-with-files-ruby/
https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
https://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/Response
https://passwordsgenerator.net/
https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Elementary-OS-and-Linux-Mint.htm
https://www.comparitech.com/blog/vpn-privacy/hide-ip-address-free/
http://wanip.info/
https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/
https://stackoverflow.com/questions/3669801/dry-way-to-assign-hash-values-to-an-object
https://stackoverflow.com/questions/7759321/disable-rails-sql-logging-in-console
https://devconnected.com/how-to-undo-last-git-commit/#:~:text=The%20easiest%20way%20to%20undo,removed%20from%20your%20Git%20history.
https://medium.com/@9cv9official/what-are-get-post-put-patch-delete-a-walkthrough-with-javascripts-fetch-api-17be31755d28
https://docs.mapbox.com/mapbox-gl-js/api/
https://docs.mapbox.com/mapbox-gl-js/example/mouse-position/
https://blockbuilder.org/FergusDevelopmentLLC/4492644236d3836913bcd1339de1854b
https://bl.ocks.org/FergusDevelopmentLLC/4492644236d3836913bcd1339de1854b/94fee5dbffaf9bcbf15740d3c77c10c4b6f7f8b1
https://medium.com/@Nicholson85/handling-cors-issues-in-your-rails-api-120dfbcb8a24
https://stackoverflow.com/questions/36878255/allow-access-control-allow-origin-header-using-html5-fetch-api
https://dev.to/shoupn/javascript-fetch-api-and-using-asyncawait-47mp
https://konvajs.org/docs/styling/Mouse_Cursor.html
https://iconify.design/icon-sets/?query=target
https://stackoverflow.com/questions/155188/trigger-a-button-click-with-javascript-on-the-enter-key-in-a-text-box
https://gifyu.com/?lang=en
https://www.npmjs.com/package/parameterize
https://gist.github.com/pjambet/3710461
https://stackoverflow.com/questions/456177/function-overloading-in-javascript-best-practices
https://stackoverflow.com/questions/47639248/using-an-array-of-longitudes-and-latitudes-to-plot-on-mapbox
https://codepen.io/AshutoshD/pen/dMEGqM
https://stackoverflow.com/questions/684672/how-do-i-loop-through-or-enumerate-a-javascript-object
https://docs.mapbox.com/help/tutorials/create-interactive-hover-effects-with-mapbox-gl-js/
https://tarekraafat.github.io/autoComplete.js/demo/
https://www.digitalocean.com/community/tutorials/how-to-set-up-ruby-on-rails-with-postgres
https://www.digitalocean.com/community/tutorials/how-to-set-up-ruby-on-rails-with-postgres
https://stackoverflow.com/questions/58065428/vanilla-rails-6-0-error-command-webpack-not-found
https://www.reddit.com/r/rails/comments/71by4m/help_the_asset_applicationcss_is_not_present_in/
https://medium.com/front-end-weekly/how-to-fixing-error-peer-authentication-failed-for-user-username-in-rails-244b93671f23
https://mirrors.tripadvisor.com/centos-vault/3.5/docs/html/rhel-sbs-en-3/s1-navigating-pwd.html#:~:text=To%20determine%20the%20exact%20location,
and%20type%20the%20command%20pwd.&text=When%20you%20typed%20pwd%2C%20you,in%20the%20shell%20prompt%20window.
https://stackoverflow.com/questions/2748607/how-to-thoroughly-purge-and-reinstall-postgresql-on-ubuntu
https://stackoverflow.com/questions/9987171/rails-fatal-peer-authentication-failed-for-user-pgerror
https://stackoverflow.com/questions/32519062/how-to-start-a-rails-server-forever-on-ubuntu/32523742
https://prathamesh.tech/2019/08/26/understanding-webpacker-in-rails-6/
https://www.reddit.com/r/rails/comments/71by4m/help_the_asset_applicationcss_is_not_present_in/
https://passwordsgenerator.net/
https://www.postgresqltutorial.com/postgresql-change-password/
https://dba.stackexchange.com/questions/58312/how-to-get-the-name-of-the-current-database-from-within-postgresql
https://www.digitalocean.com/community/questions/how-to-reset-the-firewall-on-ubuntu
https://www.digitalocean.com/community/questions/opening-ports-on-my-server
https://www.digitalocean.com/community/tutorials/how-to-use-nmap-to-scan-for-open-ports-on-your-vps
https://futurestud.io/tutorials/remove-all-whitespace-from-a-string-in-javascript
http://htmlshell.com/
http://compass-style.org/reference/compass/css3/
https://dev.to/stephenafamo/how-to-create-an-autocomplete-input-with-plain-javascript
http://jsfiddle.net/rockyjreed/8GcSF/
https://www.w3schools.com/jsref/jsref_startswith.asp
https://stackoverflow.com/questions/1789945/how-to-check-whether-a-string-contains-a-substring-in-javascript
https://www.digitalocean.com/community/questions/problem-502-bad-gateway-nginx-1-10-3-ubuntu
https://askubuntu.com/questions/409541/save-the-terminal-history-to-a-file-for-print
https://stackoverflow.com/questions/36168658/mapbox-gl-setstyle-removes-layers
https://bl.ocks.org/tristen/0c0ed34e210a04e89984
https://gis.stackexchange.com/questions/208989/how-to-test-if-a-layer-exist-in-a-mapbox-gl-js-map
https://docs.mapbox.com/mapbox-gl-js/example/setstyle/
https://stackoverflow.com/questions/4816099/chrome-sendrequest-error-typeerror-converting-circular-structure-to-json
https://docs.mapbox.com/mapbox-gl-js/example/popup-on-click/
https://stackoverflow.com/questions/3669801/dry-way-to-assign-hash-values-to-an-object
https://stackoverflow.com/questions/15769739/determining-type-of-an-object-in-ruby
https://apidock.com/rails/v4.0.2/ActiveRecord/Relation/find_or_create_by
https://googlechrome.github.io/samples/fetch-api/fetch-post.html
https://stackoverflow.com/questions/24565589/can-i-pass-default-value-to-rails-generate-migration

https://devcenter.heroku.com/articles/renaming-apps#updating-git-remotes
https://postgis.net/docs/AddGeometryColumn.html