From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect handling of function pointers
Date: Fri, 10 Mar 2017 18:44:46 +0100
Message-ID: <20170310174445.4fmyibgvl7yyaz2s@macbook.local>
References: <CACXZuxeHAXK11Tyx0PSg_uqDo0rZ3Cw+aZ5gN1S_LpPMZG8cCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34567 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdCJRou (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Mar 2017 12:44:50 -0500
Received: by mail-wr0-f177.google.com with SMTP id l37so69474226wrc.1
        for <linux-sparse@vger.kernel.org>; Fri, 10 Mar 2017 09:44:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeHAXK11Tyx0PSg_uqDo0rZ3Cw+aZ5gN1S_LpPMZG8cCQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 10, 2017 at 02:23:26PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> This example fails:
> 
> extern int (*f) (int);
> int main(int argc, const char *argv[]) {
>  if (f) {
>   return (*f)(6);
>  }
> }
> 
> The linearized output is:
> 
> main:
> .L0:
>         <entry-point>
>         load.64     %r1(f) <- 0[f]
>         br          %r1(f), .L1, .L3
> .L1:
>         load        %r3 <- 0[%r1(f)]
>         call.32     %r4 <- %r3, $6
>         br          .L3
> .L3:
>         ret.32      %r4
> 
> It is the second load that is failing. Am investigating the cause - it
> seems something to do with calc_memop_addr().

No, it's a problem with the linearized code.
There is no reasons for this second load to even exist.
You can see this by replacing '(*f)(6)' by the equivalent 'f(6)'.

Also you should be careful with this example as there is no
return for the 'else' part which create some undefined value
which can create weirdness.

-- Luc Van Oostenryck
