From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 19:15:05 +0200
Message-ID: <20170327171504.jsj3yez4r5doha3r@macpro.local>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
 <20170327010342.vd34svh3kee43qir@macpro.local>
 <444abf20-b5ef-664a-fed4-ebfd8969e1da@ramsayjones.plus.com>
 <CAExDi1TwkQj4JcmxqLkG868H2QDEr87=xYHKH0sMY=AXjrEb4A@mail.gmail.com>
 <b3629c23-28e6-370d-0716-787e34a8f854@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34841 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbdC0RZJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:25:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so12287527wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:25:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b3629c23-28e6-370d-0716-787e34a8f854@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Mar 27, 2017 at 05:53:17PM +0100, Ramsay Jones wrote:
> 
> > OK, thanks.
> > It should be OK as I new tested it on a 32bit machine but
> > another environment is always good for testing.
> 
> OK, so I tested the 5 patch series + the v2 patch that you sent
> out on Linux 64bit, Linux 32bit and cygwin 64bit.
> 
> I applied the patches on top of the current 'sparse-next' branch:
> 
>   $ git branch -v
>     chrisl-master   ce18a90 sparse: update __builtin_object_size() prototype
>     master          fbbfc73 simplify float-to-float casts that doesn't change size
>     mingw           9e96dd5 test-suite: Add -b option to ignore CR at eol on MinGW
>     sparse-next     f7817f0 llvm: cleanup of output_[ptr]cast()
>   * sparse-next-tmp df7cd04 fix expansion of integers to floats
> 
>   $ git log --oneline sparse-next..
>   df7cd04 fix expansion of integers to floats
>   83de8c4 do not depends on limits.h to test __CHAR_BIT__
>   ac9f7b4 fix test validation/div.c
>   153d5cf predefine __SIZEOF_INT__ & friends
>   a3a916c predefine __INT_MAX__ and friends
>   26a0a0a fix test for cast to bool on 32bit machines
>   $ 
> 
> On Linux 64bit, I get:
> 
>   $ make check
>   ...
>   Out of 214 tests, 205 passed, 9 failed (9 of them are known to fail)
>   39 tests were disabled
>   $ 
> 
> On Linux 32bit, I get:
> 
>   $ make check
>   ...
>        TEST     call-inlined (call-inlined.c)
>   error: actual output text does not match expected output text.
>   error: see call-inlined.c.output.* for further investigation.
>   --- call-inlined.c.output.expected	2017-03-27 16:57:23.438683323 +0100
>   +++ call-inlined.c.output.got	2017-03-27 16:57:23.442685323 +0100

Yes, this is expected. Sorry, I should have told earlier.
Those were part of another serie that I didn't yes sent an updated
version. The 5 patches series only covered what's already in master,
not sparse-next.

I'll sent an updated version for what's in sparse-next a bit later.

-- Luc
