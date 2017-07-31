From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking pre-process.c
Date: Mon, 31 Jul 2017 15:32:59 -0400
Message-ID: <CANeU7QmQq16x=goRYiaACoR8LG+U8CkXoNOiPk10opFUVvG1MA@mail.gmail.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
 <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
 <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
 <98295bf9-09e7-84ca-382b-3f479ed2e0f9@ramsayjones.plus.com>
 <6545856e-5cb3-aad0-af87-bea7c0ccafd7@ramsayjones.plus.com>
 <CANeU7QmDjsviVwSU-WDNGc=tF4V8nObs4-Ao0C29B2nPvsZS-w@mail.gmail.com> <3cc11c1f-380a-cfb6-3192-b91ebd09d14c@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34466 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdGaTdA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 15:33:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id t86so5297875pfe.1
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 12:32:59 -0700 (PDT)
In-Reply-To: <3cc11c1f-380a-cfb6-3192-b91ebd09d14c@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Jul 31, 2017 at 12:21 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 31/07/17 16:51, Christopher Li wrote:
> I thought of it more as a non-override-able list of cflags, which
> are required for 'correct'/'desired' behaviour. The CFLAGS are
> supposed to be user settable from the command line. So, for example,
> if you wanted to compile c2xml and override the CFLAGS, then you must
> know to add the output of '$(PKG_CONFIG) --cflags libxml-2.0' manually.

I think CFLAGS are used by makefile implicate rules. So it has pre-existing
usage pattern there. Setting CFLAGS on command line is most likely not going
to work with most open source project out there, unless you give a very detai
 and long CFLAGS.

>
> I'm OK with any of the three too, but I actually think the last
> patch is the best. ;-)

In that  case, will the simplest one line change one a better middle
ground then?
Obvious there is only one file need to add flags here. Just keep it simple.
If more complicate flags setting required later for self checking, we can always
introduce the CHECK_CFFLAGS later. Just asking.

Chris
