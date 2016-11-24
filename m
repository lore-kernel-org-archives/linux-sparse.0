From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Thu, 24 Nov 2016 02:36:14 +0100
Message-ID: <20161124013613.GA18220@macpro.local>
References: <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net>
 <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local>
 <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122201650.GA12172@macpro.local>
 <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
 <20161123204838.GA14875@macpro.local>
 <CANeU7Qm56E34mgRz0ntwQ74gmdmEgzd4jEPw6Uuw5UW8UFR85A@mail.gmail.com>
 <CANeU7QmQ1pg=AjK++kG-RSX3z36qHNHPfkfi_DkeFpOLga_70w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36482 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935138AbcKXBgR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 20:36:17 -0500
Received: by mail-wj0-f196.google.com with SMTP id jb2so2233883wjb.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 17:36:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmQ1pg=AjK++kG-RSX3z36qHNHPfkfi_DkeFpOLga_70w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Nov 24, 2016 at 08:58:35AM +0800, Christopher Li wrote:
> +/* The arguments are constant if the cost of all of them is zero */
> +int expand_bswap(struct expression *expr, int cost)
> +{
> +	struct symbol *sym;
> +	struct expression_list *args = expr->args;
> +	long long input;
> +	int count;
> +
> +	if (cost)
> +		return cost;
> +
> +	sym = expr->fn->ctype;
> +	count = expression_list_size(args);
> +	if (count != 1) {
> +		sparse_error(expr->pos, "Invaild number of arguments for function %s (expected 1 got %d)",

Small typo here: "Invaild"
