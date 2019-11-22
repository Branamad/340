module.exports = function(){
    var express = require('express');
    var router = express.Router();


    function getGuilds(res, mysql, context, complete){
        mysql.pool.query("SELECT name, raid_groups, numberofcharacters FROM Guild", function(error, results, fields){
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
        getGuilds(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('guild', context);
            }

        }
    });

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
       var steve = mysql.pool.escape(req.params.s);
        var sql = "INSERT INTO `Guild` (name, numberofcharacters) VALUES (?,?)";
        var inserts = [req.body.gname, 1];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/guild');
            }
        });
    });

     
    return router;
}();
