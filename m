From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 13:36:26 -0700
Message-ID: <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:47711 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbZG1Ug1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 16:36:27 -0400
Received: by qyk9 with SMTP id 9so232288qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2009 13:36:27 -0700 (PDT)
In-Reply-To: <20090728181803.GA20845@merkur.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 28, 2009 at 11:18 AM, Sam Ravnborg<sam@ravnborg.org> wrote:
> In the kernel we would like to avoid all
> unused include files.
> Especially in the headers we export to userspace.
>
> Are there any easy way we can use sparse to detect
> that a specific header file is not used?

I don't know a way to do that with current sparse.
We can implement some code for this.

We need to have a good definition of what is used.

> The header files I have in mind will be fully self-contained
> as they all include the header files they need to be used.

But a lot of case we have the header file is used in *another*
file.

>
> Sample:
>
> cat foo.h:
> #include <linux/types.h>
> #include <linux/swab.h>
>
> struct foo {
> =A0 =A0 =A0 =A0__u32 bar;
> =A0 =A0 =A0 =A0__u32 baz;
> };
>
> EOF
>
>
> Here <linux/swab.h> is obviously not used.
> And I would like sparse to flag this...

I don't think it is can be turn on by default.
What if some user space program want to include foo.h
and use the definitional inside "swab.h"? In that case it will
be OK. I don't think we can ban this kind of the usage case.

Looking at the header file itself is not good enough. It also depend
on how the user include it. What macro has been defined.
That will change the behavior of the header file as well.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
