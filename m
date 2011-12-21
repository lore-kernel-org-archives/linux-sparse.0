From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] sparse, llvm: Add test case for <stdbool.h> type
Date: Wed, 21 Dec 2011 01:58:10 -0800
Message-ID: <20111221095810.GA27308@leaf>
References: <1324459528-9344-1-git-send-email-penberg@kernel.org>
 <1324459528-9344-2-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45832 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1LUJ6R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Dec 2011 04:58:17 -0500
Content-Disposition: inline
In-Reply-To: <1324459528-9344-2-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Dec 21, 2011 at 11:25:27AM +0200, Pekka Enberg wrote:
> As it turns out, our validation test harness doesn't catch <stdbool.h> related
> breakage so add a minimal test case that does.
[...]
> --- /dev/null
> +++ b/validation/backend/bool-test.c
> @@ -0,0 +1,11 @@
> +#include <stdbool.h>
> +
> +static bool return_false(void)
> +{
> +	return false;
> +}

Do we want tests that depend on system header files?

- Josh Triplett
