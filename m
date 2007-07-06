From: Pavel Roskin <proski@gnu.org>
Subject: Re: [patch 5/9] x86_64: arch_pick_mmap_layout() fixlet
Date: Fri, 06 Jul 2007 17:39:48 -0400
Message-ID: <1183757988.26511.60.camel@dv>
References: <200707060939.l669drk2019988@imap1.linux-foundation.org>
	 <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
	 <1183751626.2613.54.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:44471 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760761AbXGFVj4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 17:39:56 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I6vWv-0007Rm-2N
	for linux-sparse@vger.kernel.org; Fri, 06 Jul 2007 17:39:57 -0400
In-Reply-To: <1183751626.2613.54.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Josh Triplett <josh@freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, adobriyan@sw.ru, ak@suse.de

On Fri, 2007-07-06 at 12:53 -0700, Josh Triplett wrote:

> I do think the sparse warning logic needs some work.  -Wall logically
> should mean "all warnings", but gcc historically uses it to mean "some
> reasonable set of warnings".  However, since Sparse exists solely to
> give warnings, it defaults to "some reasonable set of warnings", and
> uses -Wall for "all warnings".  Perhaps for gcc compatibility, that
> should change.

I agree in principle, but I'm yet to hear of a warning that sparse emits
and that should not be enabled by -Wall.

>   I'd love to hear suggestions for how Sparse should
> behave.  A few options:
> 
>       * Leave the current behavior, and tell people annoyed by Sparse
>         warnings they don't care about that they should either avoid
>         -Wall or use -Wall -Wno-warning-i-do-not-care-about.

That's the best approach until sparse learns to report some ridiculously
minor warnings.

>       * Ignore -Wall since we already give a reasonable default set of
>         warnings, and possibly introduce a -Weverything or similar that
>         really does mean "turn on every Sparse warning".

gcc has -Wextra (formerly -W) to enable some (but still not all)
warnings not enabled by -Wall.  The warnings not enabled by -Wall
-Wextra include e.g. -Wlong-long and -Winline, which search so some
specific conditions (long long used, function cannot be inlined etc).

I'm ignoring "-pedantic", "-ansi" and language standards for now, as
they have more effect than just the set of warnings.

If we want to be (sort of) gcc compatible, we would have following
groups:

1) Severe warnings - always enabled.  Such warnings should always be
avoided by the programmers, as they are likely to break or they indicate
some non-trivial assumptions that should be better expressed in the
code.  Example - implicit cast from pointer to integer.

2) Major warnings - enabled by -Wall.  They may be harder to find and
trickier to avoid, but they should be avoided too.  They may indicate
poorly written but correct code.  Example - missing prototype.

3) Minor warnings - enabled by -Wextra.  Such warnings may be OK in some
cases, although pedantic coders would want to avoid them.  Example -
comparing signed and unsigned integers.

4) Specific warnings - enabled by specific flags.  Those are not
warnings in a usual sense.  They are used to look for some conditions
that can affect e.g. performance retardation or portability to some
unusual platforms.  Examples - use of long long, explicit cast from
pointer to integer.

Some of the groups can be are empty now.  If no warning can be
classified as "major", then sparse will ignore -Wall.  Given that
warnings is sparse's main product, I can imagine that to be the case,
i.e. nothing is hard for sparse to find.

>       * Change -Wall to mean "turn on some additional warnings, but not
>         all of them".  We then have to decide which warnings -Wall
>         should enable, and again we might want to add a -Weverything.

As I said, whether sparse recognizes -Wall depends on classification of
the warnings.  I'm not very enthusiastic about -Weverything, as it would
(eventually) dump together "warnings" that are not actually warnings.
(Oh horror, your program uses long long and casts pointers to integers
explicitly!)

>       * Turn off all warnings by default unless you give -Wall.  This
>         seems entirely broken, given the purpose of Sparse.

Indeed, that would be wrong, unless we decide that sparse cannot
recognize any severe warnings.

-- 
Regards,
Pavel Roskin
