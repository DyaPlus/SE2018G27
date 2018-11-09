import axios from 'axios';

var baseUrl = ""

var client_host = window.location.hostname;

// var server_host = client_host;
if(client_host === "localhost") {
	var server_host = "localhost:8000"
	var protocol = window.location.protocol
	baseUrl = protocol + "//" + server_host
}

var config = {
	baseURL: baseUrl,
	
}

var Client = axios.create(config)

export default Client;

