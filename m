From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/5] replace test for c99 for-loop initializers
Date: Sun, 19 Feb 2017 20:58:41 +0000
Message-ID: <1ebf742e-5680-4160-6dc5-808fcfb5cc44@ramsayjones.plus.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
 <20170218203048.22276-2-luc.vanoostenryck@gmail.com>
 <12926366-f68d-460a-a181-cd30303631d5@ramsayjones.plus.com>
 <20170219011037.rv6k23uvdst2gfxt@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:41414 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdBSU6o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Feb 2017 15:58:44 -0500
In-Reply-To: <20170219011037.rv6k23uvdst2gfxt@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>



On 19/02/17 01:10, Luc Van Oostenryck wrote:
> On Sat, Feb 18, 2017 at 10:37:36PM +0000, Ramsay Jones wrote:
>>
>>
>> On 18/02/17 20:30, Luc Van Oostenryck wrote:
>>> The existing test is an indirect test, using a warning
>>> about context imbalance to show that some part of code
>>> was discarded.
>>>
>>> Now that we have the minimal tools to test the output of
>>> test-linearize, use them to replace the test by a direct one.
>>
>> Hmm, it may be a more direct test, but it is not clear
>> just what is being tested (or indeed how it is being tested).
>>
>>
>> After applying this patch, I edited validation/c99-for-loop.c
>> like so:
>>
>>     $ git diff
>>     diff --git a/validation/c99-for-loop.c b/validation/c99-for-loop.c
>>     index 427fde2..6b24fa8 100644
>>     --- a/validation/c99-for-loop.c
>>     +++ b/validation/c99-for-loop.c
>>     @@ -2,8 +2,9 @@ int c99(void);
>>      int c99(void)
>>      {
>>             int r = -1;
>>     +       int i;
>>  
>>     -       for (int i = 0; i < 10; i++) {
>>     +       for (i = 0; i < 10; i++) {
>>                     r = i;
>>             }
>>  
>>     $ 
>>
>> This modified test still passes (indeed the output is identical).
>> :-P
>>
>> ATB,
>> Ramsay Jones
> 
> Which is wonderful because it's exactly what it should be.

So why is it called c99-for-loop.c? ;-) [rhetorical question]

> In fact I would love to be able to do this: show that two versions
> of a program/function give exactly the same output, but the testsuite
> can't do that (yet).

OK

> Now, you're right that It's may be not very clear what is being tested.

Indeed! (So, the commit message could use some improvement, right?)

> I may make more sense once you replace it in the context of the patch
> it replace and the associated fix:
> - 0e91f878 ("validation: Check C99 for loop variables")
> - ed73fd32 ("linearize: Emit C99 declarations correctly")

OK, so that sheds some light on the issue ...

> If you try the test case on the tree with the patch ed73fd32 reverted,
> you will see that the two versions doesn't give anymore the same result:
> The C89 version (your) version will still give the right output
> but the C99 version (the one of the test case) will essentialy gives
> an empty output (the code used to ignore the C99-style declaration
> and patch ed73fd32 fixed that).

Yes, I can confirm this behaviour. If I 'git revert ed73fd32' then
rebuild, sure enough the c99 version is 'essentially empty', but the
c89 version is as before.

So, how could I tell from the commit message alone, that this is what
the test is doing?

ATB,
Ramsay Jones

