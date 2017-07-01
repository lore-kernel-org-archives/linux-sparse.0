From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse release v0.5.1 RC3
Date: Sat, 1 Jul 2017 22:46:52 +0200
Message-ID: <20170701204651.gfgarvt6nag7mbur@ltop.local>
References: <CANeU7Q=q8PVxavt1CegVebT9aSnQ2ugXrE4PStf7ey08Kg+NpA@mail.gmail.com>
 <b79fe0eb-06fa-d7fd-67c6-988ed578fbf2@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35219 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdGAUqy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 16:46:54 -0400
Received: by mail-wm0-f43.google.com with SMTP id w126so136626632wme.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 13:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b79fe0eb-06fa-d7fd-67c6-988ed578fbf2@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>

On Sat, Jul 01, 2017 at 09:31:58PM +0100, Ramsay Jones wrote:
> 
> 
> On 30/06/17 02:30, Christopher Li wrote:
> > I have update the master on sparse git repository to
> > RC3. We actually skip the RC2 on this release.
> > 
> > https://git.kernel.org/pub/scm/devel/sparse/sparse.git/
> > 
> > Compare to RC1, most noticeably fix some "crazy programmer"
> > error on compiling git source code. Thanks Luc for contribute
> > most of the patches from RC1.
> > 
> > Again, please give it a good test. Report back what issue
> > you might find. If there is no big issue, I plan to tag the finial version
> > of v0.5.1 next week.
> 
> Tested on Linux (i686 and x86_64) and cygwin (x86_64).
> 
> Both the sparse testsuite and 'make sparse' on the git tree
> work as expected, without additional failures.
> 
> Thanks! :-D

Thanks again for the testing.

-- Luc 
