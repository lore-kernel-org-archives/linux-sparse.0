From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm duplicate declarations of data
Date: Thu, 16 Mar 2017 18:25:06 +0100
Message-ID: <20170316172505.xgk5s4xircz37ftp@macbook.local>
References: <CACXZuxcpyux92Jwe4HodmReoNwiefM7L0OnzX0XMDZ5gm6RAEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35016 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbdCPRZK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 13:25:10 -0400
Received: by mail-wm0-f41.google.com with SMTP id u132so40975980wmg.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 10:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcpyux92Jwe4HodmReoNwiefM7L0OnzX0XMDZ5gm6RAEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 08:29:46PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> In the following test case:
> 
> static int once;
> static int once = 1;
> extern int printf(const char *, ...);
> static int value(int *p)
> {
>  return *p;
> }
> int main(void)
> {
>  return value(&once) == 1 ? 0 : 1;
> }
> 
> Sparse-llvm declares the global 'once' twice as there is a check
> missing on whether the global has already been defined.

Yes, this is a known issue.
It's because sparse doesn't do yet the consolidation of declarations.


-- Luc
