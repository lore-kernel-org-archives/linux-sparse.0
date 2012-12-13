From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Add GCC's byteswap intrinsics
Date: Thu, 13 Dec 2012 08:11:19 -0800
Message-ID: <20121213161119.GA8149@leaf>
References: <1355406304.19560.39.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49975 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab2LMQLZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Dec 2012 11:11:25 -0500
Content-Disposition: inline
In-Reply-To: <1355406304.19560.39.camel@shinybook.infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Dec 13, 2012 at 01:45:04PM +0000, David Woodhouse wrote:
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> ---
> I'm about to make the kernel use these:
>  http://git.infradead.org/users/dwmw2/byteswap.git
> 
>  lib.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib.c b/lib.c
> index 396e9f1..d747a3e 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -698,6 +698,11 @@ void declare_builtin_functions(void)
>  	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
>  	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
>  
> +	/* And byte-swapping operations.. */
> +	add_pre_buffer("extern short __builtin_bswap16(short);\n");
> +	add_pre_buffer("extern int __builtin_bswap32(int);\n");
> +	add_pre_buffer("extern long long __builtin_bswap64(long long);\n");

GCC defines these to use int16_t, int32_t, and int64_t, respectively.
The first two of those should match up to "short" and "int" without any
issue, but on 64-bit platforms, stdint.h defines int64_t as "long", not
"long long".  That could lead to some type incompatibilities.

- Josh Triplett
