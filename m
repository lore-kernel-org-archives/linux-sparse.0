From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v4 0/13] Generic Red-Black Trees
Date: Sat, 23 Jun 2012 18:01:08 -0500
Message-ID: <4FE64AB4.1010904@landley.net>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47072 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab2FWXBX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 23 Jun 2012 19:01:23 -0400
Received: by obbuo13 with SMTP id uo13so4098414obb.19
        for <linux-sparse@vger.kernel.org>; Sat, 23 Jun 2012 16:01:23 -0700 (PDT)
In-Reply-To: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>

On 06/22/2012 11:00 PM, Daniel Santos wrote:
> Theory of Operation
> ===================
> Historically, genericity in C meant function pointers, the overhead of a
> function call and the inability of the compiler to optimize code across
> the function call boundary.  GCC has been getting better and better at
> optimization and determining when a value is a compile-time constant and
> compiling it out.  As of gcc 4.6, it has finally reached a point where
> it's possible to have generic search & insert cores that optimize
> exactly as well as if they were hand-coded. (see also gcc man page:
> -findirect-inlining)

For those of us who stopped upgrading gcc when it went to a non-open
license, and the people trying to escape to llvm/pcc/open64/tcc/qcc/etc
and build the kernel with that, this will simply be "less optimized"
rather than "you're SOL, hail stallman"?

> Layer 2: Type-Safety
> --------------------
> In order to achieve type-safety of a generic interface in C, we must
> delve deep into the darkened Swamps of The Preprocessor and confront the
> Prince of Darkness himself: Big Ugly Macro.  To be fair, there is an
> alternative solution (discussed in History & Design Goals), the
> so-called "x-macro" or "supermacro" where you #define some pre-processor
> values and include an unguarded header file.  With 17 parameters, I
> choose this solution for its ease of use and brevity, but it's an area
> worth debate.

Because this is just _filling_ me with confidence about portability and
c99 compliance.

(Or I suppose C11!!one! compliance. The new thing that puts asserts in
the base language and makes u8 a keyword since _that_ won't break
existing code and putting utf8 string constants within quotes wasn't
previously possible.)

I'm not saying the standard's perfect, I'm saying a web page that ties
itself to mozilla at the expense of working on firefox, let alone
chrome, might be a bit short-sighted these days. XFree86 begat x.org,
OpenOffice begat libre, etc. The FSF went nuts again and this time
around EGCS is called LLVM, so talking about gcc 4.6-only features
thrills some of us less than you might expect.

I suppose sparse has to be able to cope with this, so that's something...

> To avoid needing multiple versions of the macro, we use a paradigm

Indeed.

I still have trouble remembering how trampolines work when I wander away
for a while. Oh well...

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
