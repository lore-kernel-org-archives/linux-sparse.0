From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/4] Makefile: adding debug version of sparse
Date: Sun, 13 Aug 2017 20:24:34 -0400
Message-ID: <CANeU7QnD-swKVD1p44Upds1_Nm6cARu0+QU_gk0kkBhtHvpoZg@mail.gmail.com>
References: <CANeU7Q=HyZNGXRFydfuxD5KRRwQ-gjMyH4u4OHcmnrttKtFe8A@mail.gmail.com>
 <CAExDi1SiYjFEAWLHSQUL_we=aFAC=AufBezQQtpyZb4uMttFOw@mail.gmail.com>
 <CANeU7Q=dv0k3UzHmNeOXwdgojsx6hRQDkwoAxRc7v=Bs0eCJrQ@mail.gmail.com> <3cce2a1d-4944-5286-2c40-5271da10aabe@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36796 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdHNAYf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 20:24:35 -0400
Received: by mail-yw0-f195.google.com with SMTP id n83so5352858ywn.3
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 17:24:35 -0700 (PDT)
In-Reply-To: <3cce2a1d-4944-5286-2c40-5271da10aabe@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 13, 2017 at 5:38 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
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
>
>        Once your commits are ready to be sent to the mailing list, run the
>        following commands:

Thank you. That is what I just try in the other email. Some how
gmail want to go through some step that I am not comfortable doing.
That is why I wish git send-email has gmail oauth2 support.

I search the internet, some people get it to work using the smtp
server but some did not.

I will find a way to do it.

Thanks again.

Chris
