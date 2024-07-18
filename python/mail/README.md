## SEND EMAIL DAILY
To automate sending daily email reports in Python, you can use the `smtplib` library for sending emails and `schedule` for scheduling tasks. Here's a step-by-step guide to set it up:

### Step 1: Install Required Libraries

First, ensure you have the necessary libraries installed. You can install them using pip:

```bash
pip install schedule
```

### Step 2: Write the Python Script

Here's a script to send an email with a daily report:

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import schedule
import time

# Function to send email
def send_email():
    from_address = "your_email@example.com"
    to_address = "recipient_email@example.com"
    subject = "Daily Report"
    body = "This is the body of the daily report email."

    # Create the email headers and content
    msg = MIMEMultipart()
    msg['From'] = from_address
    msg['To'] = to_address
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    # Set up the server
    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()

    # Login to your email account
    server.login(from_address, "your_password")

    # Send the email
    server.sendmail(from_address, to_address, msg.as_string())

    # Close the server connection
    server.quit()

    print("Email sent successfully!")

# Schedule the email to be sent daily
schedule.every().day.at("09:00").do(send_email)

# Keep the script running
while True:
    schedule.run_pending()
    time.sleep(1)
```

### Step 3: Configure Your Email Account

1. **Email Address and Password:** Replace `your_email@example.com` and `your_password` with your actual email address and password.
2. **SMTP Server:** Replace `smtp.example.com` with the SMTP server address of your email provider. For example, Gmail's SMTP server is `smtp.gmail.com`.

### Step 4: Schedule the Script to Run Daily

To run the script continuously and ensure it sends emails daily, you can use a process manager like `systemd` on Linux or Task Scheduler on Windows.

#### Using `systemd` on Linux

1. **Create a Service File:**

   Create a new file in `/etc/systemd/system` called `daily_email_report.service`:

   ```ini
   [Unit]
   Description=Daily Email Report

   [Service]
   ExecStart=/usr/bin/python3 /path/to/your_script.py
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

2. **Start and Enable the Service:**

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl start daily_email_report.service
   sudo systemctl enable daily_email_report.service
   ```

### Conclusion

This setup will run a Python script that sends a daily email report. Adjust the script's content, SMTP settings, and scheduling as needed for your specific requirements.