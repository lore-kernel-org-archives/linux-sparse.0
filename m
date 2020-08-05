Return-Path: <SRS0=17k7=BP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F9C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  5 Aug 2020 20:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3D422B42
	for <linux-sparse@archiver.kernel.org>; Wed,  5 Aug 2020 20:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHEUNY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:13:24 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:41888 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgHEQXz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:55 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 520FC209AB;
        Wed,  5 Aug 2020 10:16:46 +0000 (UTC)
Date:   Wed, 5 Aug 2020 12:16:44 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>,
        linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200805101644.thiecht24afwoxxe@comp-core-i7-2640m-0182e6>
References: <reply-9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185002@salsa.debian.org>
 <note_185155@salsa.debian.org>
 <20200802213035.w7bexg4zdusr25xf@ltop.local>
 <20200803145308.o2y4mln5fzlgdr4v@comp-core-i7-2640m-0182e6>
 <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
 <20200804200201.enysyyt6vo3l5ggl@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804200201.enysyyt6vo3l5ggl@ltop.local>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Wed, 05 Aug 2020 10:16:46 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Aug 04, 2020 at 10:02:01PM +0200, Luc Van Oostenryck wrote:
> On Tue, Aug 04, 2020 at 06:38:12PM +0200, Alexey Gladkov wrote:
> > Don't get me wrong, I don't mind renaming the utility. This is a good
> > short term solution but to be honest I don't like the name 'sparse-sindex'
> > because it is very long.
> 
> I also think 'sparse-sindex' would be a bad name for anything
> but this 'very-short-term-solution-for-this-package'.
> 
> > Can we think of something shorter ?
> 
> Yes, of course. Propose anything. You're the author of this tool,
> as such I consider that you have full moral rights on it, including
> its name.  It's really up to you.

Oh my ... You are asking to come up with a new name for a person whose
fantasy is the same as that of a stone :)

I like Oleg's idea. Let's call the utility 'dissect' if it's not already
in use.

-- 
Rgrds, legion

