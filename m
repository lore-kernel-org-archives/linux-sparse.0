From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: adding debug version of sparse
Date: Sun, 13 Aug 2017 23:47:43 +0200
Message-ID: <CAExDi1T1Pj-fZU9Bj+G_Ps4yEY=qXf3bdu92Q-TVgYAUaUsyNA@mail.gmail.com>
References: <CANeU7Q=HyZNGXRFydfuxD5KRRwQ-gjMyH4u4OHcmnrttKtFe8A@mail.gmail.com>
 <CAExDi1SiYjFEAWLHSQUL_we=aFAC=AufBezQQtpyZb4uMttFOw@mail.gmail.com>
 <CANeU7Q=dv0k3UzHmNeOXwdgojsx6hRQDkwoAxRc7v=Bs0eCJrQ@mail.gmail.com> <3cce2a1d-4944-5286-2c40-5271da10aabe@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33415 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdHMVro (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 17:47:44 -0400
Received: by mail-oi0-f53.google.com with SMTP id f11so70290305oic.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 14:47:44 -0700 (PDT)
In-Reply-To: <3cce2a1d-4944-5286-2c40-5271da10aabe@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 13, 2017 at 11:38 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> ...
>
> EXAMPLE
>    Use gmail as the smtp server
>        To use git send-email to send your patches through the GMail SMTP
>        server, edit ~/.gitconfig to specify your account settings:
>
>            [sendemail]
>                    smtpEncryption = tls
>                    smtpServer = smtp.gmail.com
>                    smtpUser = yourname@gmail.com
>                    smtpServerPort = 587
>
>        If you have multifactor authentication setup on your gmail account, you
>        will need to generate an app-specific password for use with git
>        send-email. Visit
>        https://security.google.com/settings/security/apppasswords to setup an
>        app-specific password. Once setup, you can store it with the
>        credentials helper:
>
>            $ git credential fill
>            protocol=smtp
>            host=smtp.gmail.com
>            username=youname@gmail.com
>            password=app-password

It's what I do here.

> I have to say that I find GMail such a pain that it is not
> worth using, but I know that _some_ people have actually
> managed to get it to work ... ;-)

Well, it's just using google SMTP server. The setup is
the same as for any other SMTP server and I like the
app-specific password.

Regards,
-- Luc
