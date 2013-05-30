this is my original sinatra app.

it's to test out some simple web services for simple web sites.

functions like 'contact-us' and 'subscribe'

maybe someday, i'll make it into a gem. maybe.

###development
i use [tmuxinator](https://github.com/aziz/tmuxinator) and __sin.yml__ is the tmuxinator config file for me.

###requests
POST /contact-us

POST /subscribe


###responses
success: 200 - returns the email address
error:

###tux
used for testing and what not. see the [tux readme](https://github.com/cldwalker/tux).

###some links

these articles were helpful in the creation of this code. i also made use of this book: [Service-Oriented Design with Ruby and Rails](http://www.amazon.com/gp/product/0321659368/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0321659368&linkCode=as2&tag=chamaxwoo-20) by Paul Dix even though i'm not using rails.

http://stackoverflow.com/questions/9855656/how-to-submit-a-form-using-javascript

http://stackoverflow.com/questions/4166776/ajax-form-submit

http://ghickman.co.uk/2010/09/26/creating-a-contact-page-for-jekyll-with-sinatra.html

http://vitobotta.com/sinatra-contact-form-jekyll/

http://sinatra-book.gittr.com/

http://www.speakingcode.com/2013/01/29/build-a-webservice-with-json-using-ruby-and-sinatra/
