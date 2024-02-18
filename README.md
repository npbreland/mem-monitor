# mem-monitor
Simple bash script to send an alert via Sendgrid API if memory usage exceeds a given threshold

## Usage
- If using in a new app, set up a new API key in SendGrid and follow the instructions for cURL
- Set MEM_ALERT_THRESHOLD, SERVER_NAME, SENDGRID_API_KEY, ALERT_TO_EMAIL, and ALERT_FROM_EMAIL in your user's .bash_profile
```
export MEM_ALERT_THRESHOLD=0.95 # Fraction above which you want to fire an alert
export SERVER_NAME="My Server" # Name you want to appear in the email subject
export SENDGRID_API_KEY="ABC"
export ALERT_TO_EMAIL="you@example.com"
export ALERT_FROM_EMAIL="me@example.com"
```
- Upload my mem-monitor.sh script to your user's home directory (or wherever you want)
- Enter a line in the crontab to run the script
```
crontab -e

# Add a line like
* * * * * /home/me/mem-monitor.sh
```
