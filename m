From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Sparse warnings on GENMASK + arm32
Date: Tue, 25 Jul 2017 18:30:20 -0700
Message-ID: <20170726013020.GL2146@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdGZBaW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Jul 2017 21:30:22 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I see sparse warning when I check a clk driver file in the kernel
on a 32-bit ARM build.

drivers/clk/sunxi/clk-sun6i-ar100.c:65:20: warning: cast truncates bits from constant value (3ffffffff becomes ffffffff)

The code in question looks like:

static const struct factors_data sun6i_ar100_data = {
	.mux = 16,
	.muxmask = GENMASK(1, 0),
	.table = &sun6i_ar100_config,
	.getter = sun6i_get_ar100_factors,
};

where factors_data is

struct factors_data {
	int enable;
	int mux;
	int muxmask;
	const struct clk_factors_config *table;
	void (*getter)(struct factors_request *req);
	void (*recalc)(struct factors_request *req);
	const char *name;
};


and sparse seems to be complaining about the muxmask assignment
here. Oddly, this doesn't happen on arm64 builds. Both times, I'm
checking this on an x86-64 machine.

 $ sparse --version
 v0.5.1-rc4-1-gfa71b7ac0594

Is there something confusing to sparse in the GENMASK macro?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
