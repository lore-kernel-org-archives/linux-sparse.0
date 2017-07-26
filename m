From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse warnings on GENMASK + arm32
Date: Wed, 26 Jul 2017 15:46:17 +0200
Message-ID: <20170726134616.grjb7metn7rv5alu@ltop.local>
References: <20170726013020.GL2146@codeaurora.org>
 <1000702648.38599568.1501075981880.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35855 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdGZNqV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Jul 2017 09:46:21 -0400
Content-Disposition: inline
In-Reply-To: <1000702648.38599568.1501075981880.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 26, 2017 at 09:33:01AM -0400, Lance Richardson wrote:
> > From: "Stephen Boyd" <sboyd@codeaurora.org>
> > I see sparse warning when I check a clk driver file in the kernel
> > on a 32-bit ARM build.
> > 
> > drivers/clk/sunxi/clk-sun6i-ar100.c:65:20: warning: cast truncates bits from
> > constant value (3ffffffff becomes ffffffff)
> 
> Hmm, it seems sparse is incorrectly taking ~0UL to be a 64-bit value
> while BITS_PER_LONG is (correctly) evaluated to be 32.
> 
> #define GENMASK(h, l) \
> 	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))

It's the kernel CHECKFLAGS that should be using -m32/-m64 if built
on a machine with a different wordsize tht the arch.

I sent earlier a patch for ARM, I just forgot to CC the mailing list here.

-- Luc
