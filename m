From: Christopher Li <sparse@chrisli.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 2 Aug 2014 01:27:23 -0700
Message-ID: <CANeU7Q=11kDQdW7=2m6UwCzf6pcQU05stuSp+ysPus5d1oneJA@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFxptOTqCR9b0o8sEKwzyQOU0rfKTptRY5s=j5R_X=UdUg@mail.gmail.com>
	<CA+55aFwg=yuR6Ro1O3g50Y1QR-hPeW5y_BLQ18go_DoX9SZe6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:55204 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaHBI1Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 04:27:24 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so6910137qgf.17
        for <linux-sparse@vger.kernel.org>; Sat, 02 Aug 2014 01:27:23 -0700 (PDT)
In-Reply-To: <CA+55aFwg=yuR6Ro1O3g50Y1QR-hPeW5y_BLQ18go_DoX9SZe6Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, John Keeping <john@keeping.me.uk>

On Thu, Jul 31, 2014 at 11:50 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> That leaves just my last patch ("Fix scoping of extern") as being not
> in the sparse tree, and that's irrelevant for the union initializer
> thing.

I just apply that without the "FIXME" part. That two lines are from an incorrect
fix for the external inline bug. I just remove it for now. Currently
sparse will fail
at the external inline test. I will fix that in a separate patch.

Chris
