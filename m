From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Thu, 6 Feb 2020 21:06:10 +0100
Message-ID: <20200206200610.7ktqp2yzriw7zurx@ltop.local>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38079 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUGO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Feb 2020 15:06:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so189165wmj.3
        for <linux-sparse@vger.kernel.org>; Thu, 06 Feb 2020 12:06:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, Arthur Fabre <afabre@cloudflare.com>

On Thu, Feb 06, 2020 at 10:25:39AM -0800, Randy Dunlap wrote:
> 
> All of the oom-killer instances list sphinx-build as running, and I often
> have OOM problems using it (make htmldocs), so that may be a factor.
> 
> This morning sparse is handling bpf_sk_storage.c OK (no sphinx-build running).

OK, make sense.
However, I thought that the 5+seconds of runtime with 2.9Gb of memory
consumption I reported earlier was somehow excessive. So, I looked
at the preprocessed file and my editor (and several other tools) chocked
near the end ... It appears that one line is 2.8Mb on a total of 6.2MB
and contains 28968 times the expression for num_possible_cpus().

The origin of this is situted at line 647:
	smap->bucket_log = max_t(u32, 1, ilog2(roundup_pow_of_two(...));
because ilog2() is an 'interesting' macro which is already expanded
inside roundup_pow_of_two().

This exists since the introduction of this file in commit
    6ac99e8f23d4 bpf: Introduce bpf sk local storage
but back then it made sparse consume only about 500Mb of memory on it.
Use of the macro max_t make things even worse in commit 
    85749218e3a6 ("bpf: Fix out of bounds memory access in bpf_sk_storage")

To illustrate the situation, the following patch cuts sparse memory consumption
down to 109Mb in 0.3s:

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 458be6b3eda9..bdf4a1a256c3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -644,7 +644,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	bpf_map_init_from_attr(&smap->map, attr);
 
 	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
-	smap->bucket_log = max_t(u32, 1, ilog2(roundup_pow_of_two(num_possible_cpus())));
+	smap->bucket_log = max_t(u32, 1, ilog2(__roundup_pow_of_two(num_possible_cpus())));
 	nbuckets = 1U << smap->bucket_log;
 	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
 

but a better patch should, I think, directly use ilog2() and avoid the roundup.

Cheers,
-- Luc
