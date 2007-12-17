From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [Security] Signed divides vs shifts (Re: /dev/urandom uses uninit bytes, leaks user data)
Date: Mon, 17 Dec 2007 19:08:10 +0000
Message-ID: <20071217190810.GE8181@ftp.linux.org.uk>
References: <E1J3RD5-0006yU-00@gondolin.me.apana.org.au> <alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org> <20071217185557.0b501e23.dada1@cosmosbay.com> <alpine.LFD.0.9999.0712171009570.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760157AbXLQTJP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712171009570.21557@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, security@kernel.org, tytso@mit.edu, Herbert Xu <herbert@gondor.apana.org.au>, John Reiser <jreiser@BitWagon.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, mpm@selenic.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Dec 17, 2007 at 10:28:38AM -0800, Linus Torvalds wrote:
> [ So Al, when you said that
> 
> 	(a-b)
> 
>   is equivalent to
> 
> 	((char *)a-(char *)b)/4
> 
>   for a "int *" a and b, you're right in the sense that the *result* is 
>   the same, but the code generation likely isn't. The "a-b" thing can (and 

Sure.  And yes, I very much do prefer code that uses C as it ought to be
used and doesn't play games with casts from hell, etc.  For a lot of reasons,
both correctness- and efficiency-related.

We _do_ have such turds.  In spades.  And such places are potential timebombs,
since well-intentioned idiotic patch ("I've read in lecture notes that sizeof
is better than explicit constant, so replacement surely can only improve the
things and the best part is, I don't need to understand what I'm doing")
turns an ugly FPOS into equally ugly FPOS that silently doesn't work ;-/

[sorry about the rant, I'm about 3/4 through the drivers/net colonoscopy,
with >300Kb of patches and a pile of assorted bugs so far - and then there's
drivers/scsi to deal with.  Endianness stuff, mostly...]
