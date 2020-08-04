Return-Path: <SRS0=xnzy=BO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52710C433E0
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB4B22B40
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHDQi3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:38:29 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:60938 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbgHDQi1 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Aug 2020 12:38:27 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id EB3F2209AB;
        Tue,  4 Aug 2020 16:38:14 +0000 (UTC)
Date:   Tue, 4 Aug 2020 18:38:12 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>,
        linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
References: <reply-9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185002@salsa.debian.org>
 <note_185155@salsa.debian.org>
 <20200802213035.w7bexg4zdusr25xf@ltop.local>
 <20200803145308.o2y4mln5fzlgdr4v@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803145308.o2y4mln5fzlgdr4v@comp-core-i7-2640m-0182e6>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Tue, 04 Aug 2020 16:38:15 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Aug 03, 2020 at 04:53:10PM +0200, Alexey Gladkov wrote:
> On Sun, Aug 02, 2020 at 11:30:35PM +0200, Luc Van Oostenryck wrote:
> > On Sun, Aug 02, 2020 at 08:18:42PM +0000, Uwe Kleine-König wrote:
> > > Uwe Kleine-König commented on a discussion: https://salsa.debian.org/ukleinek/sparse/-/merge_requests/2#note_185155
> > > 
> > > There is still another issue that popped up in the meantime: 
> > > https://bugs.debian.org/966706
> > 
> > Hmmm, I think that a corner of my mind was silently worried it
> > will happen.
> > 
> > > The options are:
> > > 
> > >  - add a Conflicts: biosquid
> > >    (this is the ugliest option)
> > >  - rename sindex to something else
> > >  - convince the bioquid people to rename their sindex
> > >  - stop shipping sindex
> > > 
> > > For now I will go for "stop shipping sindex", do you have an opinion for a long-term plan?
> > 
> > [+CC to sindex's author]
> > 
> > Not really.
> > Would it be easy to install it under the name 'sparse-sindex' or
> > 'sparse-index'?
> > 
> > One thing I would like (in some future release) is to split
> > the sparse package at least in 2:
> > * one with sparse itself
> >   - it has no dependencies (except the libc, a compiler compatible
> >     with gcc and GNU make for the build)
> >   - maybe cgcc should be included in the package too (which would
> >     add a dependency on perl)
> > * one with the others tools
> >   - but maybe it would even be better to the big ones in their
> >     own packages with their own dependencies)
> > But this would not really solve the problem here.
> 
> Renaming of sindex was an option for me, but since you have a plan
> to split the package anyway, then I think it's better to do so. I tried to
> use the libsparse.a and it looks like it works fine [1].
> 
> I spoke with Oleg Nesterov and he also does not mind moving this utility
> to a separate repository.
> 
> [1] https://github.com/legionus/sindex

Oleg pointed out to me that my email is not entirely clear :)

My email does not mean at all that I moved the utility to a separate
repository. I made a proof-of-concept.

Don't get me wrong, I don't mind renaming the utility. This is a good
short term solution but to be honest I don't like the name 'sparse-sindex'
because it is very long. Can we think of something shorter ?

Also, could you tell us more about your plan for future releases ?
How do you plan to split the repository ?

-- 
Rgrds, legion

