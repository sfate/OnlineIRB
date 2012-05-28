Simple Online irb tool.
===
Application provides simplified ruby console in browser. 
Based on websockets data exchange.

Technologies
--
  * [sinatra](https://github.com/sinatra/sinatra)
  * [websockets](https://github.com/simulacre/sinatra-websocket)

Run
--
Run in terminal:
```bash
$ git clone git@github.com:Sfate/OnlineIRB.git
$ cd OnlineIRB/
$ bundle install
$ bundle exec thin start -Rconfig.ru
```
Then open in browser `http://localhost:3000/`
Issues
--
http://onirb.herokuapp.com/ is non-fuctional case heroku does not support `ws://` protocol.

About
--
Sfate (c) 2012

