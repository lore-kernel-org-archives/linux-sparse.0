From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/5] replace test for c99 for-loop initializers
Date: Mon, 20 Feb 2017 14:05:48 +0000
Message-ID: <6b1a3334-0c2d-d322-c70e-d613b40dd225@ramsayjones.plus.com>
References: <1ebf742e-5680-4160-6dc5-808fcfb5cc44@ramsayjones.plus.com>
 <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
 <20170220072052.2429-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:44409 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753677AbdBTOFv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 09:05:51 -0500
In-Reply-To: <20170220072052.2429-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>



On 20/02/17 07:20, Luc Van Oostenryck wrote:
> This test is to insure that a for-loop with C99-style initializer
> linearize correctly: the same as a C89-style one (modulo any effect
> on the scope of the variables). For example that code like:
> 	for (int = 0; i < 10; i++)
> 		do_stuff(i);
> is linearized the same as  code like:
> 	int i;
> 	for (i = 0; i < 10; i++)
> 		do_stuff(i);
> 
> A test for this already exist in the testsuite:
> 	0e91f878 ("validation: Check C99 for loop variables")
> which show the correctness of the fix::
> 	ed73fd32 ("linearize: Emit C99 declarations correctly")
> But this test is an indirect one, using the presence or absence of
> warning about context imbalance to show that some part of code is
> present or not.
> 
> Now that we have the minimal tools to test the output of
> test-linearize, use them to replace the test by a direct one.
> 
> Note: ideally we would like to show that the C89 & the C99 version
> generate the same code but the testsuie deosn't allow this (yet).
> 
> CC: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Test-case-for: ed73fd32 ("linearize: Emit C99 declarations correctly")
> Replaces:      0e91f878 ("validation: Check C99 for loop variables")
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---

Yep, much better. Thanks!

ATB,
Ramsay Jones

[resent to the mailinglist]
