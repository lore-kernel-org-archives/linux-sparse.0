From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Simplify (and warn about) right shifts that result
 in zero
Date: Thu, 24 Apr 2008 17:03:03 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804241658520.2779@woody.linux-foundation.org>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk>  <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org>  <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>  <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
 <1209081131.12561.45.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54752 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796AbYDYADf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 20:03:35 -0400
In-Reply-To: <1209081131.12561.45.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>



On Thu, 24 Apr 2008, Pavel Roskin wrote:
> 
> So I would suggest a similar warning is this case.  Maybe "right shift
> too big (%u) for source type %s" (if the source type is readily
> available) or "right shift count (%d) >= width of type (%d)"

That's fine, except we shouldn't talk about "type", since we're really 
doing some really stupid value analysis (the *type* will generally have 
been cast to a bigger one by the implicit C type evaluation rules).

> By the way, your patch has caught something interesting in
> net/mac80211/tkip.c:
> 
>         iv32 = data[hdr_len + 4] +
>                 (data[hdr_len + 5] >> 8) +
>                 (data[hdr_len + 6] >> 16) +
>                 (data[hdr_len + 7] >> 24);
>
> Wow!

Heh. That does look like somebody is shifting the wrong way, and 
apparently the new warning was worth something ;)

		Linus
