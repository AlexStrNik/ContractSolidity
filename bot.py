from telegram.ext import Updater, CommandHandler, Handler, CallbackQueryHandler
import telegram
from telegram import ChatAction, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Filters, MessageHandler
from handler import SolidityHandler

updater = Updater(token='382950404:AAHai_mvYGVYQI_yc1FiXFCWlLqhdDmgnqs')
abi = """[{"constant":false,"inputs":[{"name":"adrs","type":"address"}],"name":"setProject_head","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"newOrder","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"adrs","type":"address"}],"name":"setProject_manager","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getComercial_director","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"TimeIsOut","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"confirmKDT","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"ConfirmPSItest","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"str","type":"string"}],"name":"setTechOrder","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getProject_head","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"adrs","type":"address"},{"name":"res","type":"uint256"}],"name":"addExporters","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"adrs","type":"address"}],"name":"setComercial_director","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"res","type":"uint256"}],"name":"removeRes","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getStatus","outputs":[{"name":"s","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getProject_manager","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_prise","type":"uint256"}],"name":"sertification","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getExporters","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"adrs","type":"address"}],"name":"setTecknical_director","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"adrs","type":"address"}],"name":"setMain_constructor","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"kdt","type":"string"}],"name":"organizeDev","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"printStatus","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getMain_constructor","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getTecknical_director","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getOMTC_head","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"adrs","type":"address"}],"name":"setOMTC_head","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"data","type":"string"}],"name":"createTrialProduct","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"reworkKDT","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":true,"stateMutability":"payable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"adrs","type":"address"},{"indexed":false,"name":"sttr","type":"string"},{"indexed":false,"name":"buttext","type":"string"}],"name":"sendToTelegram","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"toDir","type":"address"},{"indexed":false,"name":"fromByu","type":"address"}],"name":"order","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"sttr","type":"string"}],"name":"PSItest","type":"event"}]"""
e = SolidityHandler(abi, '0x3c871d872f03903557525aee6791186a790c4cb8')
us_to_add = {}
add_to_us = {}
add_pass = {}
botz:telegram.Bot  = None

def join(bot: telegram.Bot, update: telegram.Update):
    # print('ee')
    if update.message.chat.type == 'group':
        us_to_add[update.message.from_user.id] = update.message.text.split('/join ')[1]
        add_to_us[update.message.text.split('/join ')[1]] = update.message.from_user.id
        bot.send_message(chat_id=update.message.chat.id, text='Hello, ' + update.message.from_user.name + " !!!")
        bot.send_message(chat_id=update.message.from_user.id, text="Hello!!! Please send me password with command /pass")


@e.handle("sendToTelegram")
def sentToTel(event):
    to = add_to_us[event['args']['adrs']]
    text = event['args']['sttr']
    button = event['args']['buttext']
    if button == "Организовать разработку":
        pass
    elif button=="Переделать КДТ":
        keyboard = [InlineKeyboardButton("Option 1", callback_data='reworkKDT$'+event['args']['adrs'])]
        reply_markup = InlineKeyboardMarkup(keyboard)
        botz.send_message(chat_id=to,text=text,reply_markup=reply_markup)
    elif button=="Принять КДТ":
        keyboard = [InlineKeyboardButton("Option 1", callback_data='confirmKDT$' + event['args']['adrs'])]
        reply_markup = InlineKeyboardMarkup(keyboard)
        botz.send_message(chat_id=to, text=text, reply_markup=reply_markup)

def passcode(bot: telegram.Bot, update: telegram.Update):
    if update.message.chat.type == 'private':
        to_unlock = update.message.from_user.id
        add_pass[us_to_add[to_unlock]] = update.message.text.split('/pass ')[1]
        bot.send_message(chat_id=update.message.from_user.id,text="Thanks you. Dont worrying you passcode will be used ony for contract interaction, we dont steal your passcode or ethers")


def added(bot: telegram.Bot, update: telegram.Update):
    global botz
    botz=bot
    if update.message.new_chat_members:
        for e in update.message.new_chat_members:
            bot.send_message(chat_id=update.message.chat.id,
                             text="Hello, " + e.name + " !!! Please use join command to join to project")

def buttonC(bot, update):
    query = update.callback_query
    addr = query.data.split("$")[1]
    type = query.data.split("$")[0]
    if type == "reworkKDT":
        e.web.personal.unlockAccount(addr,add_pass[addr])
        e.deployed_contract.transact(transaction={'from':addr}).reworkKTD()
    elif type=="confirmKDT":
        e.web.personal.unlockAccount(addr, add_pass[addr])
        e.deployed_contract.transact(transaction={'from': addr}).confirmKTD()


e.start("sendToTelegram")
updater.dispatcher.add_handler(CommandHandler("join", join))
updater.dispatcher.add_handler(CommandHandler("pass", passcode))
updater.dispatcher.add_handler(CallbackQueryHandler(buttonC))
updater.dispatcher.add_handler(MessageHandler(Filters.all, added))



updater.dispatcher.add_handler(CallbackQueryHandler(buttonC))
updater.start_polling()
