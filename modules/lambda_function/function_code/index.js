const thumbnails = [
	"billy.png",
	"jimmy.jpg",
	"john.png",
	"anna.png",
	"jenny.png",
];

exports.handler = async (event) => {
	return {
		statusCode: 200,
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({ thumbnails }), //sending the array of movies as stringified JSON in the response
	};
};