From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] give a type to builtin functions
Date: Sat, 6 Jan 2018 01:26:15 +0800
Message-ID: <CANeU7QksKFY6ot9_1+_8Q2cnVh+igx8X87pTM+WJG+U-HpOJfw@mail.gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
 <20180102151116.22060-1-luc.vanoostenryck@gmail.com> <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
 <20180103155743.240cb67f567d3fb4ae970ef7@redchan.it> <20180103164057.qmhyx6eb47c26mm2@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:37470 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeAER0Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 5 Jan 2018 12:26:16 -0500
Received: by mail-yw0-f180.google.com with SMTP id v190so2011402ywg.4
        for <linux-sparse@vger.kernel.org>; Fri, 05 Jan 2018 09:26:16 -0800 (PST)
In-Reply-To: <20180103164057.qmhyx6eb47c26mm2@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: foobar <foobar@redchan.it>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jan 4, 2018 at 12:41 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> yeah, it seems odd (and annoying at the same time) that ctags emits internal symbols __builtin_bswap16 and similar stuff, unlike exuberant ctags.
>
> There is several ways to change this but I need to think a bit
> about it.

The builtin needs to be in the global scope because we don't want to lose
those function when sparse switch to the next C files.
>
> There is also that sparse's ctags work on the preprocessed source
> while, I think, other ctags work purely on the lexical level,
> thus on non-preprocessed sources.

Yes, that is by design. It is a useful feature to find out those
symbol generated from the macro expansion.

I have one idea, I haven't look closely how piratical it is.
I think we can filter out the __buildin_xxx functions by looking at
the some builtin flags in the symbol.

Chris
