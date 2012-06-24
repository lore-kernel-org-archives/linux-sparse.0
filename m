From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v4 0/13] Generic Red-Black Trees
Date: Sun, 24 Jun 2012 17:06:07 +0100
Message-ID: <20120624170607.1584c278@pyramind.ukuu.org.uk>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
	<4FE64AB4.1010904@landley.net>
	<4FE661F8.3000109@att.net>
	<4FE69A14.6040904@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4FE69A14.6040904@landley.net>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: daniel.santos@pobox.com, Daniel Santos <danielfsantos@att.net>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-sparse@vger.kernel.org

> > Forgive me, but I'm a little stumped here.  When did GCC move to a
> > "non-open" license?

It didn't

> About when it decided anti-tivoization was within its mandate, so

A lot of consider the GPLv2 license has the same requirement

> That said, reducing code duplication is a good thing. I'm just not
> convinced "how well gcc 4.6 optimizes this" is the only relevant test
> criteria here.

It is for the other 99.999999999% of users.

> LLVM/CLANG is bsd licensed (alas, with advertising clause, but code from
> it might actually be incorporatable into the linux kernel, unlke gcc,
> which is under a license extensively incompatible with the linux kernel).

Advertising clause BSD is not GPL compatible.

> Ok, so "designed with gcc 4.6's optimizer in mind, regression tested
> back to 3.4 for at least minimal functionality, and not intentionally
> breaking other compilers".

If you want it to work with weird cornercase compilers its for your
benefit so it's your problem and you do the work. Thats how free software
works. At the point lots of people starting using your compiler it might
matter more and if everyone starts using your compiler then it'll end up
being the primary optimisation target.

Alan
