From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Tue, 5 Oct 2010 09:18:30 -0700
Message-ID: <20101005161829.GB1859@feather>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:48484 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0JEQTh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Oct 2010 12:19:37 -0400
Received: from relay1-v.mail.gandi.net (relay1-v.mail.gandi.net [217.70.178.75])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 19189380CF
	for <linux-sparse@vger.kernel.org>; Tue,  5 Oct 2010 18:19:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-sparse@vger.kernel.org, michael.hennerich@analog.com

On Tue, Oct 05, 2010 at 04:34:30AM -0400, Mike Frysinger wrote:
> The Blackfin port uses some custom attributes to control memory placement,
> and it has some custom builtins.  So add the ones that the kernel actually
> utilizes to avoid massive build errors with sparse.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

I wonder, does it make sense to support these kinds of
architecture-specific builtins on all architectures, rather than
limiting them based on some specified target architecture?

Since Sparse doesn't generate code, it can easily target all
architectures simultaneously, but that doesn't mean we couldn't tell it
what architecture to target.  Sparse could default to targeting the
host architecture, which would avoid the need to pass extra flags in the
common case.

- Josh Triplett
