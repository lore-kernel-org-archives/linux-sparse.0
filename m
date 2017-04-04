From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse with 4.10?
Date: Tue, 4 Apr 2017 22:12:29 +0200
Message-ID: <CAMHZB6G2bQ9SUQLHxxmz0t5Cue73i+-U8bONyq0WMk_gikvyQg@mail.gmail.com>
References: <CAHmME9o--jumLrBbRn63ewKOE49+uYJ9B8V5FocptdwZ5Kd9Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33441 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbdDDUMb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 16:12:31 -0400
Received: by mail-qk0-f172.google.com with SMTP id h67so53323143qke.0
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 13:12:31 -0700 (PDT)
In-Reply-To: <CAHmME9o--jumLrBbRn63ewKOE49+uYJ9B8V5FocptdwZ5Kd9Fw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Apr 4, 2017 at 4:14 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey,
>
> Compiling modules against 4.10 and checking with the latest sparse git
> master yields these warnings for each and every file:
>
> ./include/linux/mm.h:1713:47: warning: unknown expression (14 0)
> ./include/linux/mm.h:1714:16: warning: call with no type!
>
> That corresponds to this function:
>
> static struct page *pmd_to_page(pmd_t *pmd)
> {
>        unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
>        return virt_to_page((void *)((unsigned long) pmd & mask));
> }
>
> Something broken with the parsing?

+ CC: mailing list

I can't reproduce this on arch/x86, neither with defconfig, nor with
allyesconfig.

Lastest sparse git master is fbbfc7309, right?
Can you send your .config and/or tell a bit more about anything
unusual you could have?

-- Luc Van Oostenryck
