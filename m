From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [ANNOUNCE] Sparse v0.6.2-rc1
Date: Tue, 16 Jun 2020 01:33:11 +0200
Message-ID: <20200615233311.nep5ssmxbkhnrg27@ltop.local>
References: <20200613020735.iqb2vd23jpomisbq@ltop.local>
 <c80024d2-6d91-4fe7-a919-3edcf4a9b80a@ramsayjones.plus.com>
 <20200614215445.rtfbx23ve57fhlbr@ltop.local>
 <d540f450-c72e-5c51-ffba-32d7eb800137@ramsayjones.plus.com>
 <CAExDi1RbuRvkQb0DAYZUdwj+XQvVn91D8rU_-_bkybfCqi10eg@mail.gmail.com>
 <9fecbef9-12c8-6374-d5cd-914c3b009afa@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXdP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 Jun 2020 19:33:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4058C061A0E
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 16:33:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o26so12848664edq.0
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 16:33:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9fecbef9-12c8-6374-d5cd-914c3b009afa@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 15, 2020 at 11:54:46PM +0100, Ramsay Jones wrote:
> 
> 
> On 15/06/2020 17:38, Luc Van Oostenryck wrote:
> > On Mon, Jun 15, 2020 at 12:37:28AM +0100, Ramsay Jones wrote:
> >> I just installed python-sphinx (on LM 19.3 it is the python2
> >> version) to give it a try, and it failed:
> >>
> >>   $ make html
> >>   Running Sphinx v1.6.7
> > 
> > This is probably too old (running 3.0 here but IIRC 2.7 or
> > 2.8 should be OK).
> 
> I'm not that surprised! I will wait until LM20 which, being based
> on Ubuntu 20.04, should hopefully have a sufficiently new version.
> 
> BTW, the on-line version of the v0.6.2 release notes look good to
> me now ... except one thing! ;-)
> 
> This part of the release notes:
> 
>   * fully propagate declarations downward.
>       For example, it means that code like:
> 
>           static int foo(void);
>           int foo(void) { return 0; }
> 
>       now behaves as expected: foo() is effectively static.
> 
> ... has the two lines of code formatted as a 'filled paragraph'.
> 
> I assume that some 'code-block' marker(s) of some description are
> required to format this correctly.

Yes, absolutely! I wonder how I didn't saw it.

Thanks a lot,
-- Luc
