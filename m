From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 12:39:23 -0800
Message-ID: <1393533563.24588.127.camel@joe-AO722>
References: <1393462087.24588.50.camel@joe-AO722>
	 <530E8C2E.7080307@zytor.com> <1393466619.24588.65.camel@joe-AO722>
	 <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722>
	 <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com>
	 <1393472326.24588.82.camel@joe-AO722> <20140227040050.GA8449@nicira.com>
	 <530EBCED.9020705@zytor.com> <20140227042636.GA9592@nicira.com>
	 <530EBFC7.9030309@zytor.com>
	 <CANeU7Q=RNXR00bQcPzJYTOcZmRSn3U31ZcadPTHu6Y_Uk0UnYw@mail.gmail.com>
	 <faa9e231-d561-417b-8b8b-95192cb0e56a@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:54656 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751202AbaB0Uj0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 15:39:26 -0500
In-Reply-To: <faa9e231-d561-417b-8b8b-95192cb0e56a@email.android.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christopher Li <sparse@chrisli.org>, Ben Pfaff <blp@nicira.com>, Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2014-02-27 at 12:26 -0800, H. Peter Anvin wrote:
> On February 27, 2014 12:22:45 PM PST, Christopher Li <sparse@chrisli.org> wrote:
> >OK. I get it nobody wants a sizeof(_Bool) warning.
> >I am going to apply this patch.

Please use V3 as I stuffed up the alphabetic order
of sizeof and shadow.

> >Should we change the default to off then?
> I would.

I'm not sure it matters much, but the linux-kernel
Makefile wouldn't need to be changed if Wsizeof_bool
is default 0.

Here's a couple of other nits:

Maybe the evaluate.c "size = bits_in_char;" assignment

        if (size == 1 && is_bool_type(type)) {
-               warning(expr->pos, "expression using sizeof bool");
+               if (Wsizeof_bool)
+                       warning(expr->pos, "expression using sizeof bool");
                size = bits_in_char;
        }

should be

	size = sizeof(_Bool) * 8;

And also, in sparse.1, Josh Triplett is shown as
the maintainer.  Maybe that should be changed to
Christopher Li


