From: josh@joshtriplett.org
Subject: Re: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Thu, 30 Apr 2015 10:38:23 -0700
Message-ID: <20150430173823.GA9379@cloud>
References: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
 <CA+55aFzZtGyz3CLF5Hjyjr0GVkx3SYui8yE9JjO5tzzHZzk78g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39594 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbD3Ri1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2015 13:38:27 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzZtGyz3CLF5Hjyjr0GVkx3SYui8yE9JjO5tzzHZzk78g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Apr 30, 2015 at 08:45:33AM -0700, Linus Torvalds wrote:
> On Tue, Apr 28, 2015 at 3:48 AM, Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > gcc knows about a new "hotpatch" attribute which sparse can safely ignore,
> > since it modifies only which code will be generated just like the
> > "no_instrument_function" attribute.
> 
> I'm wondering if sparse should just ignore all attributes it doesn't
> recognize, so that we could just remove this ever-expanding list of
> things that don't actually matter for sparse..
> 
> The "unrecognized attribute" thing made more sense way back when -
> when I wanted to get he basic attributes handled. Now it's just
> noise...

Unfortunately, ever so often there's an attribute we *can't* just
ignore, and in those cases it's better for us to warn rather than
breaking.  For instance, we won't just be able to ignore "cleanup"; we
need to actually handle it, because it affects code flow.

I think part of the problem arises because sparse claims (via the
preprocessor symbols we provide) to be whatever version of GCC it was
compiled with.  I think that's a mistake.  We should pick a version of
GCC for which we support all the attributes we actually need to do
something with, and advertise ourselves specifically as that version.
That way, a codebase that includes detection for available GCC features
will avoid feeding us attributes and other features that we don't
understand.

I suspect that 3.2 is probably the version sparse should claim to be,
for now.

We could then use something like the patch you posted, possibly with the
addition of an attribute blacklist for any attributes we know we need to
do something with but don't yet, so that we warn about *those*
attributes and no others.  For anything only supported by a newer
version of GCC, it's the code we're scanning's fault for feeding us
something we never claimed to understand.

We can then update the version of GCC we claim to be once we add support
for any features of that version of GCC that absolutely need Sparse
support.

- Josh Triplett
