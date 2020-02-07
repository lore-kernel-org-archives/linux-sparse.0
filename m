From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Fri, 7 Feb 2020 11:35:49 +0100
Message-ID: <20200207103549.lhfxdi6e57v7cvor@ltop.local>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
 <20200207003434.klmw4vuwbrkv7ykt@kafai-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40207 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGKfw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 05:35:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so2025370wru.7
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 02:35:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200207003434.klmw4vuwbrkv7ykt@kafai-mbp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin KaFai Lau <kafai@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Arthur Fabre <afabre@cloudflare.com>

On Thu, Feb 06, 2020 at 04:34:34PM -0800, Martin KaFai Lau wrote:
> On Thu, Feb 06, 2020 at 03:47:21PM -0800, Linus Torvalds wrote:
> > 
> > Instead, it could just calculate the nbuckets first, and then do the
> > "log2()" on that:
> > 
> >         /* Use at least 2 buckets, select_bucket() is undefined
> > behavior with 1 bucket */
> >         nbuckets = max_t(u32, 2, roundup_pow_of_two(num_possible_cpus()));
> >         smap->bucket_log = ilog2(buckets);
> > 
> > because honestly, that is just a whole lot more legible anyway. Maybe
> > even split _that_ up, and have the max_t as a separate thing.
> Thanks for the suggestion.  I can post a patch for this.

There is also order_base_2() which,  I think, does exactly what you
need and shouldn't have the current problem.

-- Luc 
