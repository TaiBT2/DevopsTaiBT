import openpyxl
import json
from urllib import request
import telegram
from telegram import InputFile
import telegram
import tracemalloc
import asyncio
# Create a new workbook
# workbook = openpyxl.Workbook()

# # Select the active sheet
# sheet = workbook.active

# # Add content to the sheet
# sheet['A1'] = 'Name'
# sheet['B1'] = 'Age'
# sheet['A2'] = 'Max'


# sheet['B2'] = 5

# # Save the workbook
# workbook.save('dog.xlsx')


# Your Telegram bot token
bot_token = '6494967036:AAEELbz4QMxT5TqSdRVq6SfSq0Xr10Rt-3g'

# Your Telegram chat ID
chat_id = '4021253234'

# Path to the Excel file you want to send
file_path = 'dog.xlsx'

# Create a bot instance
bot = telegram.Bot(token=bot_token)

# Send the Excel file to the chat

with open(file_path, 'rb') as file:
    # bot.send_document(chat_id=chat_id, document=InputFile(file))
    # Send the message to the chat
    message = "Hello, this is a test message!"
    bot.send_message(chat_id=chat_id, text=message)


# # Your Microsoft Graph API endpoint for sending messages to a channel
# teams_url = "https://graph.microsoft.com/v1.0/teams/{team_id}/channels/{channel_id}/messages"

# # Path to the Excel file you want to send
# file_path = 'path_to_your_excel_file.xlsx'

# # Your access token for Microsoft Graph API
# access_token = 'YOUR_ACCESS_TOKEN'

# # Construct headers with the access token
# headers = {
#     "Authorization": f"Bearer {access_token}",
#     "Content-Type": "application/json"
# }

# # Read the file and prepare the file data
# with open(file_path, 'rb') as file:
#     file_data = file.read()

# # Prepare the message payload
# payload = {
#     "body": {
#         "contentType": "html",
#         "content": "Sending an Excel file"
#     },
#     "attachments": [
#         {
#             "@odata.type": "#microsoft.graph.fileAttachment",
#             "name": "ExcelFile.xlsx",
#             "contentType": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
#             "contentBytes": file_data
#         }
#     ]
# }

# # Replace {team_id} and {channel_id} with your Team and Channel IDs respectively
# teams_url = teams_url.format(team_id='YOUR_TEAM_ID', channel_id='YOUR_CHANNEL_ID')

# # Send the request to upload the file to Teams
# response = request.post(teams_url, headers=headers, data=json.dumps(payload))

# if response.status_code == 201:
#     print("Excel file sent successfully to Teams!")
# else:
#     print(f"Failed to send the file. Status code: {response.status_code}, Error: {response.text}")

