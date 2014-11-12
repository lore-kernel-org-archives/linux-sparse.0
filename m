From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Wed, 12 Nov 2014 23:39:20 +0800
Message-ID: <CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>
References: <5400357A.5050705@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46857 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbaKLPjW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 12 Nov 2014 10:39:22 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so14595966wgg.31
        for <linux-sparse@vger.kernel.org>; Wed, 12 Nov 2014 07:39:20 -0800 (PST)
In-Reply-To: <5400357A.5050705@xs4all.nl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 29, 2014 at 4:10 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> The following test source (based on drivers/media/pci/cx88/cx88-cards.c from
> the kernel) gives these sparse warnings:
>
> cards4.c:447:36: warning: Initializer entry defined twice
> cards4.c:449:19:   also defined here
>
> I am using the latest sparse code from
> git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git.

Thanks for the bug report. It has been puzzling for me as well.
It seems there is some duplicate entry in the expression list
for the very long initializer. The duplicate entry first show up after
the expand_symbol phase. The bug will disappear if the list is
sorter.

I have narrow it down to the sort_list() function.
If we turn on " #define PARANOIA" in sort.c.
Sparse can trigger assert fail:

sparse: sort.c:89: verify_seq_sorted: Assertion `cmp (a, b) <= 0' failed.
Aborted (core dumped)

Still need more work to fix it.

Chris
