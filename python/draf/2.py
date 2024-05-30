import telegram
import asyncio
async def send_my_message(bot, chat_id):
    bot.send_message(chat_id=chat_id, text='Your message here')

async def main():
    bot_token = '6494967036:AAEELbz4QMxT5TqSdRVq6SfSq0Xr10Rt-3g'
    chat_id = '4021253234'
    bot_instance = telegram.Bot(token=bot_token)

    send_my_message(bot_instance, chat_id)  # Replace bot_instance with your bot instance

# Run the event loop
asyncio.run(main())



