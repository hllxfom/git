#!/usr/local/bin/python2.7
# -*- coding: utf-8 -*-
# Author:  root@conf.top
# Date:    2017-06-06
"""
Usage:
    python mailx.py "user1@example.com,user2@example.com" "this is subject" "this is message" "/tmp/a.csv,/tmp/b.csv"
"""

import os
import sys
import re
import datetime
import logging
import smtplib
import mimetypes
from email.mime.text import MIMEText
from email.header import Header
from email.mime.multipart import MIMEMultipart
from email import encoders
from email.message import Message
from email.mime.audio import MIMEAudio
from email.mime.base import MIMEBase
from email.mime.image import MIMEImage
from email.mime.text import MIMEText
from email.utils import formatdate


# Mail account
SMTP_HOST='smtp.exmail.qq.com'
SMTP_USER='operation_monitor@microbeam.cn'
SMTP_USERNAME='报警系统'
SMTP_PASSWD='Wpgame2017'


today = datetime.date.today()
logdir = '/home/wolfplus/bin/scripts/logs/mailx'
if not os.path.exists(logdir):
    os.makedirs(logdir)
logfile = '%s/mail-%s.log' % (logdir, today.isoformat())

logging.basicConfig(
              level=logging.INFO,
              format='%(asctime)s %(levelname)s %(message)s',
              filename=logfile
)


def checkMail(email):
    if len(email) > 7:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) != None:
            return True
    return False

def sendMail(mailto="admin@example.com", subject="sendmail test", content="this is a test mail", files=[]):
    mailto_list = []
    mailto = mailto.replace(';',',')
    for mail in mailto.split(','):
        if checkMail(mail):
            mailto_list.append(mail)

    if len(mailto_list) < 1 :
        logging.error('Mail to who?')
        return False

    outer = MIMEMultipart()
    MAIL_FROM = ("%s<"+SMTP_USER+">") % (Header(SMTP_USERNAME,'utf-8'),)
    outer['Subject'] = subject
    outer['From'] = MAIL_FROM
    outer['To'] = ', '.join(mailto_list)
    outer["Accept-Language"]="zh-CN"
    outer["Accept-Charset"]="ISO-8859-1,utf-8"
    outer['Date'] = formatdate()

    if content[-7:] == '</html>':
        msg = MIMEText(content,"html","utf-8")
    else:
        msg = MIMEText(content,"plain","utf-8")

    outer.attach(msg)

    for file in files:
        ctype, encoding = mimetypes.guess_type(file)
        if ctype is None or encoding is not None:
            ctype = "application/octet-stream"
        maintype, subtype = ctype.split("/", 1)
        with open(file, "rb") as fp:
            attachment = MIMEBase(maintype, subtype)
            attachment.set_payload(fp.read())
            encoders.encode_base64(attachment)
            attachment.add_header("Content-Disposition", "attachment", filename=os.path.basename(file))
            outer.attach(attachment)

    smtp = smtplib.SMTP()
    try:
        logging.debug("Connected to SMTP '%s', response: %i: %s",
            SMTP_HOST, *smtp.connect(SMTP_HOST))
        if SMTP_USER and SMTP_PASSWD:
            smtp.login(SMTP_USER, SMTP_PASSWD)
        failed_recipients = smtp.sendmail(
            outer['From'], mailto_list, outer.as_string())
    except smtplib.SMTPConnectError:
        logging.error("Error connecting to host '%s'", SMTP_HOST)
        raise
    except smtplib.SMTPAuthenticationError:
        logging.error(
            "Failed to authenticate with host '%s' user '%s'",
            SMTP_USER, SMTP_PASSWD)
        raise
    except smtplib.SMTPException:
        logging.error(
            "Error sending mail to host '%s' from '%s' to '%s'",
            SMTP_HOST, outer['From'], outer['To'])
        raise
    else:
        if failed_recipients:
            logging.warning(
                "Email to '%s' failed to following recipients: %r",
                outer['To'], failed_recipients)
        logging.info("Email to '%s' and subject '%s' successfully sent" % (outer['To'], subject))
    finally:
        try:
            logging.debug("Disconnected from '%s', response %i: %s",
                SMTP_HOST, *smtp.quit())
        except smtplib.SMTPServerDisconnected:
            pass # Not connected


if __name__ == '__main__':
    if len(sys.argv) < 4 :
        print 'Usage:  mail.py <Recipient> <Subject> <Message> <Attachment>'
        sys.exit(1)
    files = []
    if len(sys.argv) == 5:
        files = sys.argv[4].replace(',',';').split(';')
        for file in files:
            if not os.path.isfile(file):
                print('Attachment (%s) not exists!' % file)
                sys.exit(3)
    sys.exit(sendMail(sys.argv[1], sys.argv[2], sys.argv[3],files))

