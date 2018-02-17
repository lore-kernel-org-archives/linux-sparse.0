From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] quiet memset() warning with sizeof(VLA)
Date: Sat, 17 Feb 2018 11:18:26 -0800
Message-ID: <20180217191826.GA22695@localhost>
References: <20180217165839.61981-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50267 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeBQTSb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 14:18:31 -0500
Content-Disposition: inline
In-Reply-To: <20180217165839.61981-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Feb 17, 2018 at 05:58:39PM +0100, Luc Van Oostenryck wrote:
> Currently, sparse doesn't handle yet VLA's sizeof(). The size
> of a VLA is considered as zero and the result of sizeof() on
> a VLA is treated as an error with a value of -1.
> 
> That's a problem with the check done by the sparse tool, which
> warn when operations like memset() are done with a static count
> which is above some limit. Of course, all this is done with
> unsigned numbers and the -1 from sizeof(VLA) is then considered
> as off-limit.
> 
> Sure, size of VLAs should be supported but it's longer term.
> One short term solution would be to do the check with signed
> numbers but that would eat the upper bit of the limit which
> may well be the bound that we would like to check.
> 
> So, check instead for sizes of -1, which must come from some
> previous errors that must have already been reported, and do
> not issue the memset() warning in this case.

I'm concerned about generically ignoring this warning for *all* -1
sizes, because -1 seems like a very common value to slip through for
other reasons.  Losing those very real warnings just to avoid getting a
second warning on a VLA doesn't seem worth it.

(Also, at the very *least* this would need a comment explaining *why* it
ignores -1.)

Could you somehow propagate a taintedness on that value that causes the
memset to ignore it? Or just change the dummy error value to 0?

>  sparse.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sparse.c b/sparse.c
> index bceacd94e..5f53a9b9b 100644
> --- a/sparse.c
> +++ b/sparse.c
> @@ -153,6 +153,8 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
>  		return;
>  	if (count->type == PSEUDO_VAL) {
>  		unsigned long long val = count->value;
> +		if (val == -1ULL)
> +			return;
>  		if (Wmemcpy_max_count && val > fmemcpy_max_count)
>  			warning(insn->pos, "%s with byte count of %llu",
>  				show_ident(insn->func->sym->ident), val);
> -- 
> 2.16.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
