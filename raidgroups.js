module.exports = function(){
    var express = require('express');
    var router = express.Router();


    function getRaidGroups(res, mysql, context, complete){
        mysql.pool.query("SELECT raid_group_id AS id, raid_name, Character.name AS leader FROM `Raid_Group` INNER JOIN `Character` ON Raid_Group.raid_group_leader = Character.character_id ", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.raidgroup = results;
            complete();
        });
    }  

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getRaidGroups(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('raidGroup', context);
            }

        }
    });

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO `Raid_Group` (raid_name, raid_group_leader) VALUES (?,?)";
        var inserts = [req.body.rgname, 1];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/raidGroup');
            }
        });
    });

     
    return router;
}();
