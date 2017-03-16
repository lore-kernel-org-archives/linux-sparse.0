From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Seg fault in linearizer after latest patch series
Date: Thu, 16 Mar 2017 17:30:59 +0100
Message-ID: <20170316163058.7qdlzqdogdc2svfq@macbook.local>
References: <CACXZuxd6UpSy=ztcn2nE+58DkimdQ9aaerLQgW7hAJXv1gbmuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36469 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdCPQbD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 12:31:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11so116550403wma.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 09:31:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd6UpSy=ztcn2nE+58DkimdQ9aaerLQgW7hAJXv1gbmuQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 16, 2017 at 12:24:03AM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> I am getting a segmentation fault in the linearizer - which I
> replicated using  your GitHub repository branch llvm-fixes-v2.
> 
> Please try -v option when running test-linearizer on this program.
> Other programs also cause this. Looks like the offending line is
> accessing the def field in a pseudo - and I think one of your recent
> changes does not set def anymore?
> 
> static double test(double *p)
> {
>  double x;
>  x = *p;
>  return x;
> }
> int main(void)
> {
> 
>  double u,v;
>  v = 42.0;
>  u = test(&v);
>  return v;
> }

Hi,

Yes, there is several such crashes that may arise with the -v option,
I mean, even without the llvm serie.

I've a trivial patch for some of the cases since a little while,
I just need a bit more time.

Luc
