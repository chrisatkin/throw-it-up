Firebase = require './firebase'
jQuery = require './jquery'

image_limit = 10
unique_identifier = "h3kf394"

fb = new Firebase "https://throw-it-up.firebaseio.com#{unique_identifier}"

fb.on('child_added', (snapshot) ->

)

fb.on('')