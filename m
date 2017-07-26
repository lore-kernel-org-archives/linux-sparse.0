From: Lance Richardson <lrichard@redhat.com>
Subject: Re: Sparse warnings on GENMASK + arm32
Date: Wed, 26 Jul 2017 09:33:01 -0400 (EDT)
Message-ID: <1000702648.38599568.1501075981880.JavaMail.zimbra@redhat.com>
References: <20170726013020.GL2146@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbdGZNdC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Jul 2017 09:33:02 -0400
In-Reply-To: <20170726013020.GL2146@codeaurora.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

> From: "Stephen Boyd" <sboyd@codeaurora.org>
> To: linux-sparse@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Sent: Tuesday, 25 July, 2017 9:30:20 PM
> Subject: Sparse warnings on GENMASK + arm32
> 
> I see sparse warning when I check a clk driver file in the kernel
> on a 32-bit ARM build.
> 
> drivers/clk/sunxi/clk-sun6i-ar100.c:65:20: warning: cast truncates bits from
> constant value (3ffffffff becomes ffffffff)
> 
> The code in question looks like:
> 
> static const struct factors_data sun6i_ar100_data = {
> 	.mux = 16,
> 	.muxmask = GENMASK(1, 0),
> 	.table = &sun6i_ar100_config,
> 	.getter = sun6i_get_ar100_factors,
> };
> 
> where factors_data is
> 
> struct factors_data {
> 	int enable;
> 	int mux;
> 	int muxmask;
> 	const struct clk_factors_config *table;
> 	void (*getter)(struct factors_request *req);
> 	void (*recalc)(struct factors_request *req);
> 	const char *name;
> };
> 
> 
> and sparse seems to be complaining about the muxmask assignment
> here. Oddly, this doesn't happen on arm64 builds. Both times, I'm
> checking this on an x86-64 machine.
> 
>  $ sparse --version
>  v0.5.1-rc4-1-gfa71b7ac0594
> 
> Is there something confusing to sparse in the GENMASK macro?
> 

Hmm, it seems sparse is incorrectly taking ~0UL to be a 64-bit value
while BITS_PER_LONG is (correctly) evaluated to be 32.

#define GENMASK(h, l) \
	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
