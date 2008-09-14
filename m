From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] sparse: Make pre_buffer dynamically increasable
Date: Sun, 14 Sep 2008 21:41:59 +0900 (JST)
Message-ID: <20080914.214159.128616923.anemo@mba.ocn.ne.jp>
References: <20080720.002224.108306935.anemo@mba.ocn.ne.jp>
	<20080914.004951.41872502.anemo@mba.ocn.ne.jp>
	<70318cbf0809131059w70c47e4dkb324e0f198b22ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:55808 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbYINMls (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Sep 2008 08:41:48 -0400
In-Reply-To: <70318cbf0809131059w70c47e4dkb324e0f198b22ba@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, linux-mips@linux-mips.org, sam@ravnborg.org, viro@zeniv.linux.org.uk

On Sat, 13 Sep 2008 10:59:45 -0700, "Christopher Li" <sparse@chrisli.org> wrote:
> The better way is just remove the pre_buffer completely. Just tokenize
> the buffer
> and append the result token on the fly.
> 
> Can you try out the patch I attached? It does just that.

Thanks, it works for me.

---
Atsushi Nemoto
