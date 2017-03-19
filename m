From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Cast to double being removed
Date: Sun, 19 Mar 2017 16:22:39 +0100
Message-ID: <20170319152238.th3ts4pn7fcecpkt@macpro.local>
References: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36784 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdCSPWn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:22:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id n11so46760323wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:22:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 17, 2017 at 12:00:00AM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> In this simple example:
> 
> extern int printf(const char *, ...);
> int main(void)
> {
>     printf("%f\n", (double)-1);
>     return 0;
> }
> 
> The linearized output is:
> 
> main:
> .L0:
>         <entry-point>
>         symaddr.64  %r1 <- <anon symbol:000001BAAB487258>
>         call.32     %r2 <- printf, %r1, $-1
>         ret.32      $0
> 
> The cast to double has been removed. I am trying to understand where
> this is happening as it seems to happen quite early on. Any tips on
> where I should look?

This is fixed by the patch I sent two days ago:
	https://patchwork.kernel.org/patch/9618765/

-- Luc 
