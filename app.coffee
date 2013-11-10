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
      'Content-Type': 'application/json; charset=utf-8', 'Transfer-Encoding': 'chunked'
  )
  res.end()
  twit.stream('statuses/filter', {track: req.params.hash}, (stream) ->
    stream.on('data', (data) ->
      if data.entities? and data.entities.media? and data.entities.media[0].media_url?
        url = data.entities.media[0].media_url
        text = data.text
        id = data.id
        swab = util.inspect({text: text, image_url: url, id: id})
        console.log(swab)
        fb = new Firebase "https://throw-it-up.firebaseIO.com/wait_queue/#{req.params.hash}"
        fb.push({text: text, image_url: url, id: id})
    )
  )

app.get '/:folder/:file', (req, res) ->
  res.sendfile(__dirname + "/public/#{req.params.folder}/#{req.params.file}")


app.listen 3000