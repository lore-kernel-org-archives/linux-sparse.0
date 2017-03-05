From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm the result of expression add assign when target is a
 pointer should be a pointer
Date: Sun, 5 Mar 2017 11:53:29 +0100
Message-ID: <20170305105328.bcl7xe3mg34gtyzz@macpro.local>
References: <CACXZuxe1xK9A7PKnHzYYTemKv5Jvf1Wiam5V77inn1ReLiSQSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36761 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdCEKxe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 05:53:34 -0500
Received: by mail-wr0-f169.google.com with SMTP id u108so98874453wrb.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 02:53:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxe1xK9A7PKnHzYYTemKv5Jvf1Wiam5V77inn1ReLiSQSg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 05, 2017 at 07:29:33AM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> I am starting a new thread on this issue. When processing following
> simple example:
> 
> char *incr(char *p) {
>  char *tmp = p;
>  tmp += 5;
>  return tmp;
> }

There is indeed a problem with this example.
 
> This results in following sequence:
> 
> incr:
> .L000001CB177AD5C8:
>         <entry-point>
>         ptrcast.64  %r3 <- (64) %arg1
>         add.64      %r4 <- %r3, $5
>         cast.64     %r5 <- (64) %r4
>         ret.64      %r5

You must first upgrade to a recent version of sparse as
you seem to not have some fundamental patches here (especially
the patch https://patchwork.kernel.org/patch/9516077/ I've
already talked about it to you). The master branch should be good
the one named 'sparse-next' would be even better.

The linearized code should be:
	incr:
	.L0:
	        <entry-point>
	        cast.64     %r3 <- (64) %arg1
	        add.64      %r4 <- %r3, $5
	        ptrcast.64  %r5 <- (64) %r4
	        ret.64      %r5

Notice the difference in the casts.


-- Luc Van Oostenryck
