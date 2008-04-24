From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2/2] Simplify (and warn about) right shifts that result
	in zero
Date: Thu, 24 Apr 2008 19:52:11 -0400
Message-ID: <1209081131.12561.45.camel@dv>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk>
	 <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:37060 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbYDXXwO (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 19:52:14 -0400
In-Reply-To: <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Thu, 2008-04-24 at 14:54 -0700, Linus Torvalds wrote:
> +		warning(insn->pos, "right shift by bigger than source value");

The sparse warning for shifts exceeding the target width is:

"shift too big (%d) for type %d"

And the gcc 4.3 warning is

"right shift count >= width of type"

So I would suggest a similar warning is this case.  Maybe "right shift
too big (%u) for source type %s" (if the source type is readily
available) or "right shift count (%d) >= width of type (%d)"

By the way, your patch has caught something interesting in
net/mac80211/tkip.c:

        iv32 = data[hdr_len + 4] +
                (data[hdr_len + 5] >> 8) +
                (data[hdr_len + 6] >> 16) +
                (data[hdr_len + 7] >> 24);

Wow!

-- 
Regards,
Pavel Roskin
