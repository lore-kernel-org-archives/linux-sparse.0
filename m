Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A7DC433E6
	for <linux-sparse@archiver.kernel.org>; Mon, 15 Feb 2021 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4667C64D5D
	for <linux-sparse@archiver.kernel.org>; Mon, 15 Feb 2021 11:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBOLcv (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 15 Feb 2021 06:32:51 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50534 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhBOLcu (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 Feb 2021 06:32:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 28D97FB03;
        Mon, 15 Feb 2021 12:32:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JGyDCSRY25EI; Mon, 15 Feb 2021 12:32:06 +0100 (CET)
Date:   Mon, 15 Feb 2021 12:32:05 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status
 register
Message-ID: <YCpbtV8TyIuCmy+4@bogon.m.sigxcpu.org>
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian>
 <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
 <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com>
 <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
 <20210214204127.ezrlr4u76onqcxl7@mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214204127.ezrlr4u76onqcxl7@mail>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,
On Sun, Feb 14, 2021 at 09:41:27PM +0100, Luc Van Oostenryck wrote:
> On Sun, Feb 14, 2021 at 11:00:48AM -0800, Linus Torvalds wrote:
> > On Sun, Feb 14, 2021 at 10:42 AM Ramsay Jones
> > <ramsay@ramsayjones.plus.com> wrote:
> > >
> > > >
> > > > I looked around but didn't find any hints how to fix this. Any pointers
> > > > I missed (added the sparse list to cc:)?
> > >
> > > This is a limitation of sparse; when using the 'stringize' pre-processor
> > > operator #, the maximum size of the resulting string is about 8k (if I
> > > remember correctly).
> > 
> > Well, yes and no.
> > 
> > The C89 standard actually says that a string literal can be at most
> > 509 characters to be portable. C99 increased it to 4095 characters.
> > 
> > Sparse makes the limit higher, and the limit could easily be expanded
> > way past 8kB - but the point is that large string literals are
> > actually not guaranteed to be valid C.
> > 
> > So honestly, it really sounds like that TRACE_EVENT() thing is doing
> > something it shouldn't be doing.
> 
> In itself, it's OKish but it does a lot of macro expansions and most
> arguments are macros of macros of ... but the problem seems to be
> limited to TP_printk().
> 
> In the current case, the offender is the string 'print_fmt_tps6598x_status'
> which is just under 26K long especially because it expand
> TPS6598X_STATUS_FLAGS_MASK but also because the arguments use FIELD_GET()
> and thus __BF_FIELD_CHECK().

That was a great hint! Using a custom FIELD_GET() that drops the
__BF_FIELD_CHECK() makes things fit.
Cheers,
 -- Guido

> > 
> > I don't think there's any fundamental limit why sparse does 8kB as a
> > limit (just a few random buffers). Making sparse accept larger ones
> > should be as simple as just increasing MAX_STRING, but I really don't
> > think the kernel should encourage that kind of excessive string sizes.
> 
> Like you noted, there are just a few cases in the kernel and IIRC
> there is or was one case in it too.
> I would tend to increase MAX_STRING to something like 32 or 64K,
> in order to keep it reasonable but let sparse to continue its processing,
> but add a warning when the string/token is bigger than the current 8K.
> 
> -- Luc
> 
