From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: rhashtable sparse annotations?
Date: Thu, 10 Sep 2015 01:32:02 +0200
Message-ID: <CAHc6FU6GSLb1tY3i8+d1-3WLnesdT6M6PMqFNYKFG6LzHJvcwQ@mail.gmail.com>
References: <CAHc6FU5U81nz+1eZeg13A4CX-+v06mOyMwY0mXQYrbRKNV=Bmw@mail.gmail.com>
	<20150909211351.GD23451@pox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36059 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbIIXcE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Sep 2015 19:32:04 -0400
Received: by lanb10 with SMTP id b10so16870704lan.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Sep 2015 16:32:02 -0700 (PDT)
In-Reply-To: <20150909211351.GD23451@pox.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

2015-09-09 23:13 GMT+02:00 Thomas Graf <tgraf@suug.ch>:
> On 09/09/15 at 04:14pm, Andreas Gruenbacher wrote:
>> I'm hitting the same kinds of errors in the gfs2 rhashtable code as
>> well, but it doesn't seem to happen in the network code. Does this
>> need fixing in rhashtable?
>
> What's the rhashtable related sparse error for gfs2?

Mmh, it seems I was mixing things up: I do get the same kind of error
as in dcache.c, but the code is not rhashtable related, it's also a
hlist_bl_for_each_entry_rcu() loop. Sorry for the rhashtable noise,
Thomas.

Does anybody know how to fix the dcache.c sparse errors?

Thanks,
Andreas
