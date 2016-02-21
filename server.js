//Lets require/import the HTTP module
var http = require('http');
var dispatcher = require('httpdispatcher');
var url = require('url');
//Lets define a port we want to listen to
const PORT=8081; 

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database : 'sensordb'
});

connection.connect();

// //We need a function which handles requests and send response
// function handleRequest(request, response){
//     response.end('It Works!! Path Hit: ' + request.url);
// }

// //Create a server
 var server = http.createServer(handleRequest);
//Lets use our dispatcher
function handleRequest(request, response){
    try {
        //log the request on console
        console.log(request.url);
        //Disptach
        dispatcher.dispatch(request, response);
    } catch(err) {
        console.log(err);
    }
}
//For all your static (js/css/images/etc.) set the directory name (relative path).
dispatcher.setStatic('resources');

//A sample GET request    
dispatcher.onGet("/getSensorValues", function(req, res) {
	var sId = url.parse(req.url, true).query['id'];
var rows;
	//logic
	connection.query('SELECT * from data where sid="'+sId+'\"', function(err, rows, fields) {
  if (!err)
  {
    console.log('The solution is: ');
    var jsonResult = JSON.stringify(rows);
console.log(jsonResult);

    res.writeHead(200, {'Content-Type': 'application/json'});

    res.end(jsonResult);
}
  else
    res.end('Error while performing Query.');
});

});    

dispatcher.onGet("/putSensorValues", function(req, res) {
	console.log("GGG");
	var sId = url.parse(req.url, true).query['sid'];
	var value = url.parse(req.url, true).query['value'];
var rows;
	//logic
	connection.query('INSERT INTO `data`(`sid`, `value`) VALUES ("'+sId+'","'+value+'")', function(err, rows, fields) {
  if (!err)
  {
    console.log('The solution is: ');
  
console.log(rows);

    res.writeHead(200, {'Content-Type': 'application/json'});

    res.end("1");
}
  else
    res.end('Error while performing Query.');
});

});    

//A sample POST request
dispatcher.onPost("/post1", function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Got Post Data');
});
//Lets start our server
server.listen(PORT, function(){
    //Callback triggered when server is successfully listening. Hurray!
    console.log("Server listening on: http://localhost:%s", PORT);
});