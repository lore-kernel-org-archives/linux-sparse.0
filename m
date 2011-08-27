From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 08:29:12 -0700
Message-ID: <CA+55aFzGViNgNO8rkv1kT8TZBXNWoJ8kMDHFormT_EzK3LGvZQ@mail.gmail.com>
References: <4E588EB8.80808@garzik.org> <201108271334.17659.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32816 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750971Ab1H0P3g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 11:29:36 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7RFTXVH020508
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 08:29:35 -0700
Received: by wyg24 with SMTP id 24so3121555wyg.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 08:29:32 -0700 (PDT)
In-Reply-To: <201108271334.17659.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On Sat, Aug 27, 2011 at 4:34 AM, Kamil Dudka <kdudka@redhat.com> wrote:
>
> Two years ago I proposed a patch that I believe would solve your problem:
>
> https://patchwork.kernel.org/patch/40307/

Ack.

The sparse output still looks like sh*t, because when linearizing
loops sparse doesn't treat the first conditional specially, so instead
of noticing that "0 < 10" and getting rid of the first jump, it will
generate the loop with the (general) conditional at the end, which
will then result in lots of phi-nodes etc.

I guess some trivial loop optimizations might be a good idea. But
Kamil's patch looks correct, and the PHI-node cross-bb optimization
does look bogus.

                              Linus
