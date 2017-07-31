From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking pre-process.c
Date: Mon, 31 Jul 2017 11:51:53 -0400
Message-ID: <CANeU7QmDjsviVwSU-WDNGc=tF4V8nObs4-Ao0C29B2nPvsZS-w@mail.gmail.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
 <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
 <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
 <98295bf9-09e7-84ca-382b-3f479ed2e0f9@ramsayjones.plus.com> <6545856e-5cb3-aad0-af87-bea7c0ccafd7@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33873 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaPvy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 11:51:54 -0400
Received: by mail-pg0-f50.google.com with SMTP id u185so34094446pgb.1
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 08:51:54 -0700 (PDT)
In-Reply-To: <6545856e-5cb3-aad0-af87-bea7c0ccafd7@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Jul 31, 2017 at 11:29 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
>>> Ah, I see what you mean here. You want to distinguish
>>> CFLAGS for gcc, CHECKER_FLAGS for sparse specific
>>> flags.
>>
>> Err, ... well, yes and no! :-D
>>
>> The main idea is to separate the 'additional' flags passed to
>> sparse for the $(CHECKER) target - not necessarily for sparse
>> specific flags.

Yes, my mental model was CHECKER_FLAGS for flags sparse
to use. I haven't notice the small detail that -Wvla works for gcc
as well.

> Hmm, actually the following may be a better patch. what do you
> think?

Hmm. When I write the BASIC_CFLAGS, I was thinking to use it for the
common part of the CFLAGS impact the whole directory or project. Some
thing as base line, like architecture related stuff etc, nothing fancy.

Each C file might have specific different requirement, like include path etc,
Those goes to CFLAGS. The stuff get overwrite more often should have
a slightly shorter name for readability.

At least that was my mental model. Either one of the three we discuss here
is acceptable. If you have to ask me to pick, my order goes to the simplest
one line change, then introducing $(CHECKER_CFLAGS), then this one.

Chris
