From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Thu, 31 Jul 2014 19:41:06 -0700
Message-ID: <CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:51248 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaHAClH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jul 2014 22:41:07 -0400
Received: by mail-vc0-f182.google.com with SMTP id hy4so5792843vcb.13
        for <linux-sparse@vger.kernel.org>; Thu, 31 Jul 2014 19:41:06 -0700 (PDT)
In-Reply-To: <CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Chris Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Jul 31, 2014 at 7:19 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm quite sure we still screw complex intiializers up . But this makes
> at least Josh's test-case pass, and looks superficially sane.

Hmm. It exposes other problems.

For example, the fact that we look up the identifier now exposes the
fact that "first_subobject()" creates this dummy "EXPR_IDENTIFIER"
expression that has no identifier. That will then cause
"find_identifier()" to fail, which in turn causes convert_ident() to
fail. Resulting in the parse tree having remaining EXPR_IDENTIFIER
nodes, which will later result in "unknown expression (25,0)" errors.

That's easy enough to fix with just adding the proper initializer, ie

    new->expr_ident = field->ident;

to first_subobject().

But the change apparently also exposes some problems with nested
EXPR_POS cases, so now we mis-parse initializers that have multiple
levels of naming, of the type

   struct S a = { .a.b = 1 };

I haven't had the energy to figure out what went wrong with that one,
and I'm getting rather fed up with this for today, so I'm hoping
somebody else finds this at all interesting.

              Linus
