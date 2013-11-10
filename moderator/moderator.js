moderator = {

    dataRef: new Firebase('https://throw-it-up.firebaseIO.com/wait_queue'),
    deployRef: new Firebase('https://throw-it-up.firebaseIO.com/deploy_queue'),

    init: function() {
        moderator.dataRef.on('child_added', function(snapshot) {
            var node = snapshot.val();
            if(typeof node.media != "undefined") {
                $("#moderator_stream").append(
                    "<div id='" + node.id + "' class='stream_img'></div>");
                $("#" + node.id).css("background-image", "url('" + node.media.media_url + "')");
                $("#" + node.id).append("<input id='yes_" + node.id + "' class='yes_button button' type='button' value='Yes' />")
                $("#" + node.id).append("<input id='no_" + node.id + "' class='no_button button' type='button' value='No' />")
                console.log("#" + node.id);
                console.log(node.media.media_url);
                moderator.attachHandlers()
                moderator.dataRef.remove();
            }
        });
    },

    attachHandlers: function() {
        $(".yes_button").unbind("click");
        $(".yes_button").click(function() {
            var id = $(this).attr("id").substr(4);

            var tweet = {
                tweet: {
                    "id" : id,
                    "media" : {
                        "media_url" : $("#" + id).css("background-image").replace('url(','').replace(')','')
                    }
                 }
            }

            moderator.deployRef.set(tweet);
            $("#" + id).remove();
        });

        $(".no_button").unbind("click");
        $(".no_button").click(function() {
            var id = $(this).attr("id").substr(4);
            $("#" + id).remove();
        });
    }
}