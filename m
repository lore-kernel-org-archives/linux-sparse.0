From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/5] Makefile: suppress error message from shell
Date: Sun, 19 Jul 2009 07:03:17 -0700
Message-ID: <20090719140316.GB25417@feather>
References: <4A6233D0.1060502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:55174 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbZGSOUr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Jul 2009 10:20:47 -0400
Received: from relay1-v.mail.gandi.net (relay1-v.mail.gandi.net [217.70.178.75])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id D2B9B86F36
	for <linux-sparse@vger.kernel.org>; Sun, 19 Jul 2009 16:10:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A6233D0.1060502@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 09:42:56PM +0100, Ramsay Jones wrote:
> In particular, on systems which do not have 'pkg-config' installed,
> every invocation of make issues the following message:
> 
>     /bin/sh: pkg-config: command not found
> 
> Suppress the message by redirecting stderr to the bit-bucket.
[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -15,7 +15,7 @@ AR = ar
>  #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
>  #
>  
> -HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
> +HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 2>/dev/null && echo 'yes')

Seems sensible; this way, systems without pkg-config will simply end up
without HAVE_LIBXML.

- Josh Triplett
