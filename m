From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 11:53:54 -0400
Message-ID: <CANeU7Q=F=Gub_kG3Le-84AyjAJUydvqsdhgTyZxcxFgxh-vW6Q@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <20170910015622.42436-1-luc.vanoostenryck@gmail.com> <CANeU7QkHagTY2-BOnefCNxDXda5Ch2kaVBiYYa=XK3GP3HxjdQ@mail.gmail.com>
 <CAExDi1QQ4dMmS89y7bAqN=HDLiUtOHZME5XYXG8c34gYpJ_mqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36303 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdILPx4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 11:53:56 -0400
Received: by mail-yw0-f195.google.com with SMTP id r85so3762232ywg.3
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 08:53:56 -0700 (PDT)
In-Reply-To: <CAExDi1QQ4dMmS89y7bAqN=HDLiUtOHZME5XYXG8c34gYpJ_mqA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 3:10 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Please do as is the easiest for you.
> I don't mind as I don't have something that depend on it.

I have test your change does not conflict with my other Makefile
overhaul of the debug build. I already apply your patch to master.

Next thing is merge the debug build overhaul then add the config
option on top of that.

The master branch has been updated and pushed.

Thanks

Chris
