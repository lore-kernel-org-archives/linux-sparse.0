From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sat, 15 Aug 2009 15:36:03 -0700
Message-ID: <20090815223602.GA4516@feather>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
 <1250367991.14751.1.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:47098 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbZHOWkX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:23 -0400
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 656443ACF8
	for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2009 23:36:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250367991.14751.1.camel@penberg-laptop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

On Sat, Aug 15, 2009 at 11:26:31PM +0300, Pekka Enberg wrote:
> --- a/lib.c
> +++ b/lib.c
> @@ -788,6 +788,14 @@ void create_builtin_stream(void)
>  		add_pre_buffer("#define __OPTIMIZE__ 1\n");
>  	if (optimize_size)
>  		add_pre_buffer("#define __OPTIMIZE_SIZE__ 1\n");
> +
> +	/* GCC defines these for limits.h */
> +	add_pre_buffer("#weak_define __SHRT_MAX__ %d\n", __SHRT_MAX__);
> +	add_pre_buffer("#weak_define __SCHAR_MAX__ %d\n", __SCHAR_MAX__);
> +	add_pre_buffer("#weak_define __INT_MAX__ %d\n", __INT_MAX__);
> +	add_pre_buffer("#weak_define __LONG_MAX__ %ld\n", __LONG_MAX__);
> +	add_pre_buffer("#weak_define __LONG_LONG_MAX__ %lld\n", __LONG_LONG_MAX__);
> +	add_pre_buffer("#weak_define __WCHAR_MAX__ %d\n", __WCHAR_MAX__);

These defines need to have the right type suffixes.  GCC defines
__LONG_LONG_MAX__ with an LL suffix, and __LONG_MAX__ with an L suffix.
You could either add the appropriate suffixes, or better yet, stringize
the constants and print them as strings.

- Josh Triplett
