From: Christopher Li <sparse@chrisli.org>
Subject: Re: intended use of "safe"?
Date: Fri, 12 Aug 2011 10:47:11 -0700
Message-ID: <CANeU7Qn25EWmDFuQRhr2_txEhF9hguh=SMUJnNYjLPnCR2MDNg@mail.gmail.com>
References: <874o1nzx8x.fsf@blp.benpfaff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52309 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab1HLRrM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Aug 2011 13:47:12 -0400
Received: by qwk3 with SMTP id 3so1665814qwk.19
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2011 10:47:11 -0700 (PDT)
In-Reply-To: <874o1nzx8x.fsf@blp.benpfaff.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: blp@cs.stanford.edu
Cc: linux-sparse@vger.kernel.org

On Thu, Aug 11, 2011 at 10:14 AM, Ben Pfaff <blp@cs.stanford.edu> wrote=
:
> What is the intended use of the sparse "safe" attribute? =A0I do
> not see any uses of it in Linux (although there is a __safe macro
> for it). =A0I don't see any documentation for it either.

I don't know much about the safe attribute either. I find out the
commit which introduce the safe attribute by "git blame".

If a pointer is never NULL, there is not need to test the pointer.

Chris

commit 98f14350c26518f0f5c45632d145a218d468d8b8
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Fri Apr 16 18:19:30 2004 -0700

    Introduce "safe" pointer expressions.

    These are defined to never be NULL or nontrapping, and could
    help code generation, but right now only cause a warning if
    they are tested in a conditional.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
