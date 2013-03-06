From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH] sparse: Add cmd line  --version option
Date: Wed, 6 Mar 2013 13:45:50 -0800
Message-ID: <20130306214550.GA8486@jtriplet-mobl1>
References: <1362590578.1759.48.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34798 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab3CFVp6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 16:45:58 -0500
Content-Disposition: inline
In-Reply-To: <1362590578.1759.48.camel@joe-AO722>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Mar 06, 2013 at 09:22:58AM -0800, Joe Perches wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -1,5 +1,12 @@
>  VERSION=0.4.4
>  
> +HAVE_GIT:=$(shell git describe >/dev/null 2>&1 && echo 'yes')
> +ifeq ($(HAVE_GIT),yes)
> +SPARSE_VERSION=$(shell git describe)
> +else
> +SPARSE_VERSION=$(VERSION)
> +endif
> +

The "dist" target already has a call to "git describe"; could you unify
the two?  (And, ideally, avoid calling git describe twice, once for
HAVE_GIT and once for SPARSE_VERSION?)

- Josh Triplett
