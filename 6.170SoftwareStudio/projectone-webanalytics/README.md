# README

Project 1: Web Analytics
Basics of Ruby and Rails.
Ruby 3.4.1, Rails 8.0.1
Runs locally, booted via Puma

-Uses Ruby/Rails for frontend handling + Javascript script to calculate visit durations

LIMITATIONS
- All security (CORS) disable for all types of requests for simplicity sake. Could easily override the system and maliciously alter database via curl, SQL, etc
- Method of calculating visit duration is flawed. Sets a variable to the time page is loaded then waits until page is unloaded/refreshed and calculates the difference. This doesn't track if the user is actively on the tab/webpage, it doesn't track if the website is in the background or actually in use, and it keeps timer going until the page is closed.
|-> This runs up the average time massively, example site I created had an average duration of ~18k seconds. 
- No frontend buttons/easy way to navigate, have to manually type in web requests.
- Object model functions naming convention odd (PUT and GET same request url, difference functions called)

POSITIVES
- Functional minimal viable product. Implemented so dont need curl request to send PUT, javascript code works as designed. 
- Plenty of flexability in how object model is orientated. 
- Frontend clean and direct, code concise.
- mySQL database accessable and simplified
