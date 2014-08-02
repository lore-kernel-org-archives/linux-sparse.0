From: Christopher Li <sparse@chrisli.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Fri, 1 Aug 2014 22:16:59 -0700
Message-ID: <CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:63263 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbaHBFRA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 01:17:00 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so4807277qaq.41
        for <linux-sparse@vger.kernel.org>; Fri, 01 Aug 2014 22:16:59 -0700 (PDT)
In-Reply-To: <CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Aug 1, 2014 at 6:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, sadly, while that worked for my test-cases (and for Josh's
> case), it turns out to really *not* work in general: the dummy
> EXPR_IDENTIFIER that we create may end up referring to a unnamed
> union, which doesn't *have* an ident associated with it.
>
> This only really triggers when you mix named initializers with then
> relying on the whole "initialize the next one without a name", but
> that does happen. And it fundamentally breaks that whole "use
> find_identifier()" approach.
>
> So convert_ident() really cannot use find_indent(), and really does
> have to use "sym->offset". But that doesn't work for anonymous union
> members, because that offset was the offset within the anonymous
> union, not the parent structure.
>
> However, the fix is "simple". We can just say that anonymous
> union/structure member offsets have to be the offsets within the
> parent union instead, and fix things up. So how about a patch like
> this *instead* of the previous patch..

Sorry I am late for the party. This approach assume the anonymous
structure is only referenced inside the structure. There is not other
external reference. However, that assumption is not true if "-fplan9-extensions"
or "-fms-extensions" was enabled. Sparse current does not support these
two extensions. But it will be a problem if we support them down the road.

According to this gcc document:

https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html

One of the example is this:
     struct s1 { int a; };
     struct s2 { struct s1; };

You see, "struct s1" does not have a name, however "struct s1" can be
referenced from other symbol. So update the symbol offset in "struct s1"
will be wrong for the other reference of "struct s1".

Actually, the "find_identifier" call inside function "check_designators" already
calculate the correct offset. Only if we can pass that offset to
"convert_ident()".

Another idea is that, instead of using ident in EXPR_IDENTIFIER, we can
do one time find_identifier(). Then convert the EXPR_IDENTIFIER to an index
to the struct. It might take more than one index level for the anonymous
struct or union. BTW, that is very similar to the LLVM  performing the
"Get Element Pointer" instruction. Using the index, we can still reference
the anonymous struct.  This is not a trivial change. However it might be
the right thing to do if we want to support "-fplan9-extensions"

Chris
