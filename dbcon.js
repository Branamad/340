var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_spallaa',
  password        : '0344',
  database        : 'cs340_spallaa'
});
module.exports.pool = pool;
