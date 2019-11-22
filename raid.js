module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getRaids(res, mysql, context, complete){
        mysql.pool.query("SELECT raid_name FROM `Raid`", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.raid = results;
            complete();
        });
    }  

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getRaids(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('raid', context);
            }
        }
    });

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Raid (raid_name, boss, experience) VALUES (?,?,?)";
        var inserts = [req.body.raidName, req.body.bossName, req.body.experience];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/raid');
            }
        });
    });
     
    return router;
}();
