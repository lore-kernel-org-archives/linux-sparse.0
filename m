From: Martin KaFai Lau <kafai@fb.com>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Fri, 7 Feb 2020 00:29:54 -0800
Message-ID: <20200207082954.majgsx5trepwb46n@kafai-mbp>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
 <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgBGIaV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 03:30:21 -0500
Content-Disposition: inline
In-Reply-To: <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Arthur Fabre <afabre@cloudflare.com>

On Fri, Feb 07, 2020 at 07:34:57AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On 2/7/20 12:47 AM, Linus Torvalds wrote:
> > Instead, it could just calculate the nbuckets first, and then do the
> > "log2()" on that:
> > 
> >         /* Use at least 2 buckets, select_bucket() is undefined
> > behavior with 1 bucket */
> >         nbuckets = max_t(u32, 2, roundup_pow_of_two(num_possible_cpus()));
> >         smap->bucket_log = ilog2(buckets);
> 
> 
> Isn't it kind of ineffective to first round to a power of two and then
> take the ilog2 of it?
> 
> At a first glance I'd say that
> 
> 	ilog2(roundup_pow_of_two(x)) == ilog(x - 1) + 1
> 
> for x > 1. (Maybe even for x == 1? Didn't care to check, I think it
> doesn't matter for the case at hand.)
> 
> This RHS might be easier to optimize for the compiler?!
I believe x == 1 needs an extra case since ilog2(0) won't work.

Since this function (map creation) is not on the fast path,
I currently opt for Linus's suggestion which its code is more
self-explanatory.

Thanks,
Martin
