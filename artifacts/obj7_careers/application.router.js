module.exports = (app, router, upload) => {
	const controllers = require('../controllers/application.controller.js');
	var path = __basedir + '/views/';
	
	router.use((req,res,next) => {
		console.log("/" + req.method);
		next();
	});
	
	app.get('/', (req,res) => {
		res.sendFile(path + "index.html");
	});
	
	app.post('/api/upload/application', upload.single("csv"), controllers.uploadForm);
 
	app.use('/',router);
 
	app.use('*', (req,res) => {
		res.sendFile(path + "404.html");
	});
}