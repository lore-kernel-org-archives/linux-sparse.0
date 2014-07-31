From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Thu, 31 Jul 2014 11:50:30 -0700
Message-ID: <CA+55aFwg=yuR6Ro1O3g50Y1QR-hPeW5y_BLQ18go_DoX9SZe6Q@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFxptOTqCR9b0o8sEKwzyQOU0rfKTptRY5s=j5R_X=UdUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:51354 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaGaSub (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jul 2014 14:50:31 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so4980483vcb.30
        for <linux-sparse@vger.kernel.org>; Thu, 31 Jul 2014 11:50:30 -0700 (PDT)
In-Reply-To: <CA+55aFxptOTqCR9b0o8sEKwzyQOU0rfKTptRY5s=j5R_X=UdUg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Chris Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, John Keeping <john@keeping.me.uk>

On Thu, Jul 31, 2014 at 11:39 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but not in the "official" sparse tree, which hasn't seen any work
> since January afaik.

Ugh, I looked at the old "sparse/sparse.git" tree (and badly at that,
it stopped updating in April, not January). It's
"sparse/chrisl/sparse.git" these days. No wonder I didn't see any
recent work.

The sparse.wiki.kernel.org main page is the first google hit for
"sparse git tree" and mentions that old git repo, not Chris' new one.

That leaves just my last patch ("Fix scoping of extern") as being not
in the sparse tree, and that's irrelevant for the union initializer
thing.

Chris, any particular reason why the url changed?

            Linus
