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

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getPlayers(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('player', context);
            }

        }
    });

    router.post('/', function(req, res){
        console.log(req.body.player_id)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Player (user_password, user_Name, characters, accountlevel) VALUES (?,?,0,1)";
        var inserts = [req.body.user_password, req.body.user_Name, req.body.characters, req.body.accountlevel];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/player');
            }
        });
    });
     
    return router;
}();
