From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] make -m32/-m64 more useful
Date: Tue, 7 Feb 2017 10:28:09 +0800
Message-ID: <CANeU7QkTs=_JP+jeoJL+yMMDaf+eN30KBdxXQskNogp6g44EEw@mail.gmail.com>
References: <20161207173802.23314-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33247 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBGC2K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 21:28:10 -0500
Received: by mail-io0-f193.google.com with SMTP id 101so11559496iom.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Feb 2017 18:28:10 -0800 (PST)
In-Reply-To: <20161207173802.23314-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Dec 8, 2016 at 1:38 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The option -m64 to just set the size of longs & pointers to 64 bits.
>
> This patch makes this option much more effective by:
> - adding define for LONG_MAX & SIZEOF_POINTER
> - define __LP64__

I like this two change.

> - let the dual option, -m32, do the same as -m64 but for 32 bit

 +               max_int_alignment = 4;
 +               bits_in_long = 32;

This a feel a bit tricky is that, those value has its initial value
in target.c. It is strange to overwrite it with the exact same value.
It will have the effect change to the init value in target.c has no
impact on the later part of the code.

Maybe remove the init value in target.c and comment it
is overwrite during the -m64 finalize if we do it this way.

Chris
