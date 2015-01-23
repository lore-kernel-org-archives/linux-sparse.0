From: josh@joshtriplett.org
Subject: Re: [PATCH] Support __COUNTER__ macro
Date: Fri, 23 Jan 2015 14:39:41 -0800
Message-ID: <20150123223941.GC1489@cloud>
References: <20150123222644.GA691@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55337 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbbAWWjo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 17:39:44 -0500
Content-Disposition: inline
In-Reply-To: <20150123222644.GA691@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Christopher Li <sparse@chrisli.org>

On Fri, Jan 23, 2015 at 11:26:44PM +0100, Sam Ravnborg wrote:
> +	} else if (token->ident == &__COUNTER__ident) {
> +		static int counter = 0;
> +		replace_with_integer(token, counter++);

Same comment as with the other version of this patch: this shouldn't use
a static counter, because it needs to reset for each top-level source
file.

- Josh Triplett
