From: Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 08 Mar 2007 12:34:30 -0500
Message-ID: <1173375270.15842.24.camel@dv>
References: <1173319356.3546.54.camel@johannes.berg>
	 <1173371608.21465.12.camel@dv>  <1173372315.3248.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1173372315.3248.19.camel-YfaajirXv214zXjbi5bjpg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

On Thu, 2007-03-08 at 17:45 +0100, Johannes Berg wrote:
> and aborted when I got lots of errors, rt2400pci.i was created and has
> about 26k lines. Running sparse on it (sparse rt2400pci.i) takes a lot
> of memory too. I put the file up at
> http://johannes.sipsolutions.net/files/rt2400pci.i

FIELDS32 expands to some monstrosities.  Look for rt2x00_bbp_write in
the dump.  Also behold the amount of parentheses in LOWEST_BIT32.
That's almost certainly the culprit.

I understand the idea is to make gcc calculate integer logarithms at the
compile time.  That's nice, but sparse has to do the same, and it's
probably not optimized for such misuse.

-- 
Regards,
Pavel Roskin
