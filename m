From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/4] C: s/0/NULL/ for pointer type
Date: Thu, 14 May 2020 23:37:10 +0200
Message-ID: <20200514213710.vxm6vrkggdfad6kd@ltop.local>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
 <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
 <xmqqd07xem9l.fsf@gitster.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgENVhP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 May 2020 17:37:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd07xem9l.fsf@gitster.c.googlers.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>, git@vger.kernel.org, linux-sparse@vger.kernel.org

On Thu, Apr 23, 2020 at 05:54:30PM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Actually, I have a patch somewhere which suppressed the sparse warning
> > for the '= { 0 }' token sequence used in these initializations. However,
> > I don't seem to be able to find them at the moment! :(
> 
> AHHHHHhhhhhhhh.  
> 
> Thanks for reminding.  Yeah, I recall that the concensus of those
> who were vocal in that old discussion [*1*] was that "= { 0 }"
> should be taken as an idiom and should not be subject to s/0/NULL/
> conversion.
> 
> > [Luc, this topic came up on the sparse and kernel mailing-lists at one
> > point, but I didn't get around to posting my patch to the list - something
> > came up. Hopefully, I will find some time to find it and post it soon.]
> 
> 
> [References]
> 
> *1*
> 
> https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/

Sorry for the late reply.

I hadn't seen this old discussion but I vaguely remember 2 emails about
this problem, probaly on lkml, without a real discussion, but where the
opinion was the opposite.

Personally, I prefer '= { }' but yes it's not legit and it seems that
some compilers don't like it. I'll be glad to add an option to Sparse
to shut up the warnings now given by '{ 0 }'.

-- Luc
