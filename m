From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/4] Makefile: adding debug version of sparse
Date: Sun, 13 Aug 2017 22:38:17 +0100
Message-ID: <3cce2a1d-4944-5286-2c40-5271da10aabe@ramsayjones.plus.com>
References: <CANeU7Q=HyZNGXRFydfuxD5KRRwQ-gjMyH4u4OHcmnrttKtFe8A@mail.gmail.com>
 <CAExDi1SiYjFEAWLHSQUL_we=aFAC=AufBezQQtpyZb4uMttFOw@mail.gmail.com>
 <CANeU7Q=dv0k3UzHmNeOXwdgojsx6hRQDkwoAxRc7v=Bs0eCJrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:59698 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdHMViW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 17:38:22 -0400
In-Reply-To: <CANeU7Q=dv0k3UzHmNeOXwdgojsx6hRQDkwoAxRc7v=Bs0eCJrQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>



On 13/08/17 21:14, Christopher Li wrote:
> On Sun, Aug 13, 2017 at 3:31 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Chris,
>>
>> The patches you're sending are all whitespace damaged.
>> Not only these 4 ones the ones you sent before too.
> 
> Yes, gmail tend to damage white space. That is why I send
> attachment before.

Looking at 'git help format-patch', we find:

...

MUA-SPECIFIC HINTS
       Here are some hints on how to successfully submit patches inline using
       various mailers.

   GMail
       GMail does not have any way to turn off line wrapping in the web
       interface, so it will mangle any emails that you send. You can however
       use "git send-email" and send your patches through the GMail SMTP
       server, or use any IMAP email client to connect to the google IMAP
       server and forward the emails through that.

       For hints on using git send-email to send your patches through the
       GMail SMTP server, see the EXAMPLE section of git-send-email(1).

       For hints on submission using the IMAP interface, see the EXAMPLE
       section of git-imap-send(1).

...

Also, from 'git help send-email':

...

EXAMPLE
   Use gmail as the smtp server
       To use git send-email to send your patches through the GMail SMTP
       server, edit ~/.gitconfig to specify your account settings:

           [sendemail]
                   smtpEncryption = tls
                   smtpServer = smtp.gmail.com
                   smtpUser = yourname@gmail.com
                   smtpServerPort = 587

       If you have multifactor authentication setup on your gmail account, you
       will need to generate an app-specific password for use with git
       send-email. Visit
       https://security.google.com/settings/security/apppasswords to setup an
       app-specific password. Once setup, you can store it with the
       credentials helper:

           $ git credential fill
           protocol=smtp
           host=smtp.gmail.com
           username=youname@gmail.com
           password=app-password

       Once your commits are ready to be sent to the mailing list, run the
       following commands:

           $ git format-patch --cover-letter -M origin/master -o outgoing/
           $ edit outgoing/0000-*
           $ git send-email outgoing/*

       Note: the following perl modules are required Net::SMTP::SSL,
       MIME::Base64 and Authen::SASL

I have to say that I find GMail such a pain that it is not
worth using, but I know that _some_ people have actually
managed to get it to work ... ;-)

[The above documentation is just the start ...]

ATB,
Ramsay Jones

