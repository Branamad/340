module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getPlayers(res, mysql, context, complete){
        mysql.pool.query("SELECT user_Name FROM `Player`", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.player = results;
            complete();
        });
    }  

    function getGuilds(res, mysql, context, complete){
        mysql.pool.query("SELECT name FROM `Guild`", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.guild = results;
            complete();
        });
    }  

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getPlayers(res, mysql, context, complete);
        getGuilds(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('startpage', context);
            }

        }
    });
     
    return router;
}();
