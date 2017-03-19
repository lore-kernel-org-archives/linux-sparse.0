From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm the LLVM IR for select instruction fails due to
 different types
Date: Sun, 19 Mar 2017 16:18:27 +0100
Message-ID: <20170319151826.vmghnrd4k7iblmb4@macpro.local>
References: <CACXZuxcGKmEbv=Umh26U=Uermy+n1f2A9_ZmBYJHE15WBYPFrw@mail.gmail.com>
 <20170319002145.4x3amj6bnb36yocj@macbook.local>
 <CACXZuxeAaEGy25AmMky9GLrS0eetEg9O4dMTWk9TfB=Sm+Vc2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37990 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdCSP1L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:27:11 -0400
Received: by mail-wm0-f49.google.com with SMTP id t189so47507220wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:25:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeAaEGy25AmMky9GLrS0eetEg9O4dMTWk9TfB=Sm+Vc2A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 19, 2017 at 01:04:30PM +0000, Dibyendu Majumdar wrote:
> On 19 March 2017 at 00:21, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Tue, Mar 14, 2017 at 04:07:40PM +0000, Dibyendu Majumdar wrote:
> >> LLVM complains when the operands of a select are not the same type. I
> >> think it is okay to cast one of the operands to the type of the other
> >> - on the basis that subsequent operations will cast things anyway.
> >
> > Submit a test case, please.
> >

I was thinking to something for the test suite. 
Anyway, this is fixed in the llvm-fixes-v3 serie I submitted yesterday.

-- Luc
