Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DF9C433EF
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA3160FBF
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 09:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhIRJxd (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Sep 2021 05:53:33 -0400
Received: from smtp-1.orcon.net.nz ([60.234.4.34]:47989 "EHLO
        smtp-1.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhIRJxc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Sep 2021 05:53:32 -0400
Received: from [121.99.228.40] (port=57284 helo=tower)
        by smtp-1.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1mRX0V-0006SB-Bq; Sat, 18 Sep 2021 21:51:40 +1200
Date:   Sat, 18 Sep 2021 21:51:34 +1200
From:   Michael Cree <mcree@orcon.net.nz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
Message-ID: <20210918095134.GA5001@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
References: <20210915035227.630204-1-linux@roeck-us.net>
 <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net>
 <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
 <20210915223342.GA1556394@roeck-us.net>
 <CAHk-=wgQ4jsPadbo4kr4=UKn0nR+UvWUZF9Q-xv0QUXb33SVRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ4jsPadbo4kr4=UKn0nR+UvWUZF9Q-xv0QUXb33SVRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Sep 16, 2021 at 11:35:36AM -0700, Linus Torvalds wrote:
> On Wed, Sep 15, 2021 at 3:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > drivers/net/ethernet/3com/3c515.c: In function 'corkscrew_start_xmit':
> > drivers/net/ethernet/3com/3c515.c:1053:22: error:
> >         cast from pointer to integer of different size
> >
> > That is a typecast from a pointer to an int, which is then sent to an
> > i/o port. That driver should probably be disabled for 64-bit builds.
> 
> Naah. I think the Jensen actually had an ISA slot. Came with a
> whopping 8MB too, so the ISA DMA should work just fine.
> 
> Or maybe it was EISA only? I really don't remember.
> 
> It's possible that alpha should get rid of the ISA config option, and
> use ISA_BUS instead. That would be the proper config if there aren't
> actually any ISA _slots_, and it would disable the 3c515 driver.
> 
> But it turns out that the compile error is easy to fix. Just make it
> use isa_virt_to_bus(), which that driver does elsewhere anyway.
> 
> I have no way - or interest - to test that on real hardware, but I did
> check that if I relax the config I can at least build it cleanly on
> x86-64 with that change.
> 
> It can't make matters worse, and it's the RightThing(tm).
> 
> Since Micheal replied about that other alpha issue, maybe he knows
> about the ISA slot situation too?

Ah, yeah, not really.  I am not familiar with the Jensen hardware,
and have never played around with the EISA slot on the Alphas I do
have.

Cheers
Michael.
