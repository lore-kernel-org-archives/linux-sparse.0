From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 13:16:00 -0700
Message-ID: <CA+55aFyCihY76wE=cq6aw9LGG9Jc9U=R9VjTZc5sJM26k11-cw@mail.gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
 <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
 <4FD25BB2.2030300@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:65112 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758916Ab2FHUQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 16:16:24 -0400
Received: by wgbdr13 with SMTP id dr13so1217501wgb.1
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 13:16:23 -0700 (PDT)
In-Reply-To: <4FD25BB2.2030300@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pekka Enberg <penberg@kernel.org>, Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Fri, Jun 8, 2012 at 1:08 PM, Jeff Garzik <jeff@garzik.org> wrote:
>=A0LLVM API seems to "prefer" that one use GEP code
> and associated type information, and was written with this preference=
 in
> mind.

Looking at the LLVM API docs that Xi referred to, the LLVM preference
is actually pretty weak.

So I'd almost say continue with the current IR, and just do the
pointer arithmetic by hand. If LLVM doesn't treat GEP *that*
specially, doing a separate pointer arithmetic level is quite possibly
going to just cause problems: simplification of combinations of GEP
and arithmetic is potentially quite annoying and has problems that
simplification of perfectly regular addition does not.

                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
