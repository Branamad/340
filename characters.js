module.exports = function(){
    var express = require('express');
    var router = express.Router();


    function getCharacters(res, mysql, context, complete){
        mysql.pool.query("SELECT Guild.name AS guild, Character.name, raid_group, Player.user_name AS owner, class, race, level FROM `Character` INNER JOIN Player ON Character.player_id = Player.player_id LEFT JOIN Guild ON Character.guildmembership = Guild.guild_id", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.character = results;
            complete();
        });
    }  

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getCharacters(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('character', context);
            }

        }
    });

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO `Character` (name, player_id, class, race) VALUES (?,?,?,?)";
        var inserts = [req.body.cname, 1, req.body.class, req.body.race];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/character');
            }
        });
    });

     
    return router;
}();
