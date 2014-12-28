# ! /usr/bin/python
# -*- coding: utf-8 -*-

import smtplib
from datetime import date, timedelta
from email.mime.text import MIMEText


####################
# Email Settings #
####################
EMAIL_SERVER = 'smtp.exmail.qq.com'
EMAIL_SERVER_USER = ''
EMAIL_SERVER_PASSWORD = ''
DEFAULT_FROM_EMAIL = ''
EMAIL_RECEIVER = []


class Mail(object):

    email_server = EMAIL_SERVER
    email_server_user = EMAIL_SERVER_USER
    email_server_password = EMAIL_SERVER_PASSWORD
    sender = DEFAULT_FROM_EMAIL


    def __init__(self):
        self.smtp = self.connect_mail_server()

    def connect_mail_server(self):
        smtp = smtplib.SMTP()
        smtp.connect(self.email_server)
        smtp.login(self.email_server_user, self.email_server_password)

        return smtp

    def send(self, sender, receiver, title, content):
        msg = MIMEText(content, 'text', 'utf-8')
        msg['Subject'] = title
        self.smtp.sendmail(sender, receiver, msg.as_string())
        self.smtp.quit()




if __name__ == '__main__':
    sender = EMAIL_SERVER_USER
    receiver = EMAIL_RECEIVER
    LOG_FILENAME = ''
    today = date.today()
    yesterday = today - timedelta(days=1)
    title = yesterday.strftime('%Y年%m月%d日') + ' 传单二维码扫描统计'

    with open(LOG_FILENAME, 'r') as f:
        content_list = f.readlines()[-12:]
        content = '\n'.join(content_list)
    mail = Mail()
    mail.send(sender, receiver, title, content)
