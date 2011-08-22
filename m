From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/5] sparse: Enable unhandled validation tests
Date: Mon, 22 Aug 2011 08:24:01 -0700
Message-ID: <20110822152401.GB21442@leaf>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
 <1314021451-24808-2-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:52175 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1HVPbh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 11:31:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 803E686F4D
	for <linux-sparse@vger.kernel.org>; Mon, 22 Aug 2011 17:24:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314021451-24808-2-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 22, 2011 at 04:57:28PM +0300, Pekka Enberg wrote:
> This patch enables unhandled tests that did not have "check-name" specified.
> It's pointless not to run them.
[...]
> --- a/validation/badtype1.c
> +++ b/validation/badtype1.c
> @@ -1 +1,6 @@
>  static void foo(enum bar baz);
> +
> +/*
> + * check-name: enum not in scope
> + * check-known-to-fail
> + */
[...]
> --- a/validation/struct-ns2.c
> +++ b/validation/struct-ns2.c
> @@ -12,3 +12,8 @@ h (void)
>    struct Bar y;
>    y.i = 1;
>  }
> +
> +/*
> + * check-name: struct not in scope
> + * check-known-to-fail
> + */

Ouch, case in point; I didn't know these two tests had broken.

- Josh Triplett
