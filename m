From: josh@joshtriplett.org
Subject: Re: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Thu, 30 Apr 2015 12:41:34 -0700
Message-ID: <20150430194134.GC9971@cloud>
References: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
 <CA+55aFzZtGyz3CLF5Hjyjr0GVkx3SYui8yE9JjO5tzzHZzk78g@mail.gmail.com>
 <20150430173823.GA9379@cloud>
 <CA+55aFxCTx32CPkHCJM1NNv67vKHo-6yuTiLOg2Ya-=pn=O36g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59787 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbD3Tli (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2015 15:41:38 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxCTx32CPkHCJM1NNv67vKHo-6yuTiLOg2Ya-=pn=O36g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Apr 30, 2015 at 10:51:42AM -0700, Linus Torvalds wrote:
> On Thu, Apr 30, 2015 at 10:38 AM,  <josh@joshtriplett.org> wrote:
> > I think part of the problem arises because sparse claims (via the
> > preprocessor symbols we provide) to be whatever version of GCC it was
> > compiled with.  I think that's a mistake.  We should pick a version of
> > GCC for which we support all the attributes we actually need to do
> > something with, and advertise ourselves specifically as that version.
> 
> Fair enough. Although there may then be headers that are unhappy.

If you mean the GCC internal headers, I don't think those have version
checks; after all, you'd only use them with the GCC they ship with,
right? ;)

For any other headers, I think we'll get worse results by claiming to be
a version of GCC that has features we don't actually support.

> > I suspect that 3.2 is probably the version sparse should claim to be,
> > for now.
> 
> That may be too old. You can't reliably compile the kernel with gcc
> that old (some config options will complain).
> 
> At least CONFIG_GCOV_KERNEL wants 3.4 minimum.

If we want to claim to be 3.4 instead, then there are some attributes
we'll need to check for and warn if we find.  From a quick read of
https://ohse.de/uwe/articles/gcc-attributes.html I think this is a
complete list of attributes in 3.4 that sparse has to care about but
doesn't currently support:

cleanup
gcc_struct
ms_struct

"cleanup" we'll need to handle because it affects control flow;
gcc_struct and ms_struct affect structure layout, which we have warnings
related to.

For the moment, we could just add an explicit warning if we see any of
those three attributes, set our GCC version to 3.4, and then drop the
"unknown attribute" warning.

- Josh Triplett
