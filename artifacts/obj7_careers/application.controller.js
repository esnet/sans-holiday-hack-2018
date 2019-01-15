exports.uploadForm = (req, res) => {
	var applicationform = {
		firstname: req.body.firstname,
		lastname: req.body.lastname,
		email: req.body.email,
		phone: req.body.phone,
		file: req.file
	};
	
	// log applicationForm
	console.log(JSON.stringify(applicationform, null, 4));
	
	res.send('Thank you for taking the time to upload your information to our elf resources shared workshop station! Our elf resources will review your CSV work history within the next few minutes to see if you qualify to join our elite team of InfoSec Elves. If you are accepted, you will be added to our secret list of potential new elf hires located in C:\\candidate_evaluation.docx');
}