From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next assertion failures on cygwin
Date: Tue, 7 Mar 2017 07:35:59 +0100
Message-ID: <20170307063558.4itvt4mh327py6ls@macpro.local>
References: <5227848f-5c01-c250-84ec-27f5f6e2a67c@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37812 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbdCGHqo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 02:46:44 -0500
Received: by mail-wm0-f50.google.com with SMTP id n11so83471868wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 23:45:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5227848f-5c01-c250-84ec-27f5f6e2a67c@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Mar 06, 2017 at 10:17:36PM +0000, Ramsay Jones wrote:
> Hi Luc, Christopher,

Hi,

> ...
> 
> So, this looks like a cygwin specific toolchain problem. I also assumed that
> the 'backend/loop.c' test had the same problem (but I admit to never having
> checked properly!).
> 
> ...
> 
> So, again, this seems like a cygwin specific llvm tool problem.
> 
> ...
>    
>         TEST     Loops (backend/loop.c)
>    error: actual error text does not match expected error text.
>    error: see backend/loop.c.error.* for further investigation.
>    --- backend/loop.c.error.expected	2017-03-06 21:57:27.695953300 +0000
>    +++ backend/loop.c.error.got	2017-03-06 21:57:30.636386100 +0000
>    @@ -0,0 +1,2 @@
>    +assertion "ctype" failed: file "sparse-llvm.c", line 312, function: val_to_value
>    +.././sparsec: line 35:  8900 Aborted                 (core dumped) $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM

That's surprising as it appears that you have linearized code that is
different that what we have on Linux (one of the type/symbol is NULL).

It whould be very interesting to:
1) show the result of test-linearize on the file
2) replace the assert with a check followed with a dump of the
   offending pseudo (show_pseudo()) and ideally the corresponding
   instruction (show_instruction()).

> Note that 'backend/loop2.c' now also fails and, with the exception of
> the 'backend/hello.c' test, they now fail with an assert.

Odd.
 
> I don't have time to look into this further tonight (I'm guessing that
> you are not seeing this on linux), so I just wanted to let you know
> about it.
> 
> ATB,
> Ramsay Jones

No, nothing like that on Linux.
Dibyendu, are you seeing something like this on your environment?

Thanks to reporting this, alas as such I can't really do something
about it.


-- Luc Van Ooostenryck
