express = require 'express'
Firebase = require 'firebase'
util = require('util')
twitter = require('twitter')
twit = new twitter({
    consumer_key: "tjH0oBbUhOGgKsLGQXnw",
    consumer_secret: "2mrAETmRL5szvec7SUzW0xeRu5N1Vdkh47fhJuHb0",
    access_token_key: "16885134-0BcCERrzngjEixyQUwSj58723APVxfOxEgzj2cuXJ",
    access_token_secret: "C31MDbG7nJwgTPB7BWTwhHrfbR5rEiyEdpHlIlITKq7kV"
  })

app = express()
app.use express.bodyParser()

app.get '/', (req, res) ->
  res.sendfile(__dirname + '/public/index.html')

app.get '/stream/:hash', (req, res) ->
  res.writeHead(200, ->
      'Content-Type': 'application/json', 'Transfer-Encoding': 'chunked'
  )
  twit.stream('statuses/filter', {track: req.params.hash}, (stream) ->
    stream.on('data', (data) ->
      console.log(util.inspect(data))
      res.write(util.inspect(data))
    )
  )

app.listen 3000