From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] pre-process: replace use of vla's with heap allocation
Date: Sat, 29 Jul 2017 12:16:53 -0400
Message-ID: <CANeU7Q=eCq6Ndxsq8GnVNb7J=MYD=3vHjBf1R1miLPbyWkXYxg@mail.gmail.com>
References: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
 <CANeU7QkmtVVPhhanR2M7=3P9cCse0B9rXJSfx8c1NCC4aHZ-qw@mail.gmail.com>
 <cce05c3f-a309-9fa7-3107-e6e6831972aa@ramsayjones.plus.com> <CAExDi1S_mQRHQmAOOhdctbJOgLCo0pArXO6_QKY2WaNMsb9Y0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34445 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdG2QQz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 12:16:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id v190so26451692pgv.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 09:16:54 -0700 (PDT)
In-Reply-To: <CAExDi1S_mQRHQmAOOhdctbJOgLCo0pArXO6_QKY2WaNMsb9Y0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 29, 2017 at 9:17 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> My first reaction was surprise that you didn't go for the Makefile
>> idea - setting '-Wno-vla' would be the simplest solution. ;-)

Yes, I am convince too. I haven't thought of that.
You can submit a patch for '-Wno-vla'. I will apply it, but most
likely after this release.

>> My second thought was, have you done some timing tests (no I haven't)
>> and determined that this causes a noticeable slowdown?

I did some limited test it is within std on kernel compile. But I am
not very happy
about the stack usage per macro will expand to 8 argument structs regardless
how few arguments used myself. The -Wno-vla is better idea.

> Also, this is not IMO -rc4+ material.

Agree, because it changes the code behavior. Do you mind have the '-Wno-vla'
in -rc5? That should not change any code it generate. I am fine either way.

Chris
