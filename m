From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/30] LLVM fixes
Date: Sun, 19 Mar 2017 17:51:59 +0100
Message-ID: <20170319165158.6ufqlyedbs5bdd2w@macpro.local>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=LVUz35hFxdfDUp+vza=xwJP=SHx5F1ApUsLeWLqRraw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35188 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdCSQxt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 12:53:49 -0400
Received: by mail-wm0-f48.google.com with SMTP id u132so47618592wmg.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 09:52:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=LVUz35hFxdfDUp+vza=xwJP=SHx5F1ApUsLeWLqRraw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Mar 19, 2017 at 09:28:31AM -0700, Christopher Li wrote:
> On Sat, Mar 18, 2017 at 6:41 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This series solves a number of issues in sparse-llvm,
> > mainly about wrong or missing type information as needed
> > to build LLVM IR.
> > Most of these issues have been reported and investigated by
> > Dibyendu Majumdar.
> 
> 
> Thanks for the patches.
> 
> I will take a look and try it on sparse-next.

OK, thanks.
It seems that you will need to drop patch 2 as a late addition
of a test case cause a failure of in the test suite (but the code itself
is OK).

I'll respin the serie later after your review.

-- Luc 
