From: Jeff Layton <jeff.layton@primarydata.com>
Subject: Re: [sparse PATCH RFC] Revert "Revert "sparse: Bump up
 sizeof(_Bool) to 8 bits""
Date: Tue, 15 Jul 2014 22:23:50 -0400
Message-ID: <20140715222350.028a7bf6@f20.localdomain>
References: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
	<CANeU7QnRHvOQHHE2EEWNSUEwFRv66gmHfNXmgZxN+_J7=iPbHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51878 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbaGPCXx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jul 2014 22:23:53 -0400
Received: by mail-qa0-f53.google.com with SMTP id v10so196834qac.40
        for <linux-sparse@vger.kernel.org>; Tue, 15 Jul 2014 19:23:52 -0700 (PDT)
In-Reply-To: <CANeU7QnRHvOQHHE2EEWNSUEwFRv66gmHfNXmgZxN+_J7=iPbHg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>

On Tue, 15 Jul 2014 12:51:02 -0700
Christopher Li <sparse@chrisli.org> wrote:

> On Tue, Jul 15, 2014 at 8:46 AM, Jeff Layton <jlayton@primarydata.com> wrote:
> >
> >
> > The problem here is that, at least with GCC on x86_64, a _Bool always
> > seems to be end up being 8 bits (which makes sense -- how would you get
> > a pointer to it otherwise?). If you declare and initialize an array like
> > this:
> >
> >     static _Bool boolarray[3] = {
> >             [0] = 1,
> >             [1] = 1,
> >     };
> >
> > ...you get warnings like this (which are bogus):
> >
> >     ./test.c:2:10: warning: Initializer entry defined twice
> >     ./test.c:3:10:   also defined here
> 
> 
> Right.  The bug is in bits_to_bytes(). It round down instead of
> round up. "bits_in_bool" is only a default value. It can be
> reset to other value by the sparse application (sparse as
> library). So the rest of the code still need to coupe with
> it.
> 
>  How about fix bits_to_bytes() to round up:
> 
> diff --git a/target.h b/target.h
> index 1030c7c..140df3c 100644
> --- a/target.h
> +++ b/target.h
> @@ -49,7 +49,7 @@ extern int enum_alignment;
> 
>  static inline int bits_to_bytes(int bits)
>  {
> -       return bits >= 0 ? bits / bits_in_char : -1;
> +       return bits >= 0 ? (bits + bits_in_char - 1) / bits_in_char : -1;
>  }
> 

This makes the bitfield.c validation test fail:

     TEST     bitfield to integer promotion (bitfields.c)
error: actual error text does not match expected error text.
error: see bitfields.c.error.* for further investigation.
--- bitfields.c.error.expected	2014-07-15 22:01:09.236942195 -0400
+++ bitfields.c.error.got	2014-07-15 22:01:09.237942176 -0400
@@ -0,0 +1,2 @@
+bitfields.c:16:19: warning: invalid access past the end of 'y' (0 1)
+bitfields.c:16:19: warning: invalid access past the end of 'y' (0 1)

Though I haven't looked in detail yet as to why it's failing.

> >
> > integer division, and that causes the above bogus warning.
> >
> > Reset it back to 8 bits, and add a validation test that creates the
> > above array to ensure that we don't end up breaking it again.
> 
> The rest of the change looks good. Thanks for the test case.
> 
> My patch is not tested. If you are OK with it, submit a V2
> or I can fix the change for you.
> 
> Thanks
> 
> Chris


-- 
Jeff Layton <jlayton@primarydata.com>
