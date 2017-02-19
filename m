From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] replace test for c99 for-loop initializers
Date: Sun, 19 Feb 2017 02:10:38 +0100
Message-ID: <20170219011037.rv6k23uvdst2gfxt@macbook.local>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
 <20170218203048.22276-2-luc.vanoostenryck@gmail.com>
 <12926366-f68d-460a-a181-cd30303631d5@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33441 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdBSBKn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 20:10:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so8556643wmv.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Feb 2017 17:10:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <12926366-f68d-460a-a181-cd30303631d5@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Sat, Feb 18, 2017 at 10:37:36PM +0000, Ramsay Jones wrote:
> 
> 
> On 18/02/17 20:30, Luc Van Oostenryck wrote:
> > The existing test is an indirect test, using a warning
> > about context imbalance to show that some part of code
> > was discarded.
> > 
> > Now that we have the minimal tools to test the output of
> > test-linearize, use them to replace the test by a direct one.
> 
> Hmm, it may be a more direct test, but it is not clear
> just what is being tested (or indeed how it is being tested).
> 
> 
> After applying this patch, I edited validation/c99-for-loop.c
> like so:
> 
>     $ git diff
>     diff --git a/validation/c99-for-loop.c b/validation/c99-for-loop.c
>     index 427fde2..6b24fa8 100644
>     --- a/validation/c99-for-loop.c
>     +++ b/validation/c99-for-loop.c
>     @@ -2,8 +2,9 @@ int c99(void);
>      int c99(void)
>      {
>             int r = -1;
>     +       int i;
>  
>     -       for (int i = 0; i < 10; i++) {
>     +       for (i = 0; i < 10; i++) {
>                     r = i;
>             }
>  
>     $ 
> 
> This modified test still passes (indeed the output is identical).
> :-P
> 
> ATB,
> Ramsay Jones

Which is wonderful because it's exactly what it should be.

In fact I would love to be able to do this: show that two versions
of a program/function give exactly the same output, but the testsuite
can't do that (yet).

Now, you're right that It's may be not very clear what is being tested.
I may make more sense once you replace it in the context of the patch
it replace and the associated fix:
- 0e91f878 ("validation: Check C99 for loop variables")
- ed73fd32 ("linearize: Emit C99 declarations correctly")
If you try the test case on the tree with the patch ed73fd32 reverted,
you will see that the two versions doesn't give anymore the same result:
The C89 version (your) version will still give the right output
but the C99 version (the one of the test case) will essentialy gives
an empty output (the code used to ignore the C99-style declaration
and patch ed73fd32 fixed that).
Be careful also to the fact that this test case depends on testsuite
features only present on sparse-next, not on the master tree.


Luc Van Oostenryck
