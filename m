From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Fri, 23 Mar 2012 11:03:20 -0700
Message-ID: <20120323180320.GA17003@leaf>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
 <CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
 <1332493309.2882.6.camel@pasglop>
 <CANeU7Qnd23X+jpM6Byx12igAugv=-EyQ1hN8DtG4N32y1yp7pQ@mail.gmail.com>
 <CANeU7QkzM-ZLZ_NgstAjpZdSe-eSgj+-SxEqUX-g5kXBTHrCvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47110 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab2CWSDb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 14:03:31 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QkzM-ZLZ_NgstAjpZdSe-eSgj+-SxEqUX-g5kXBTHrCvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, penberg@cs.helsinki.fi, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Crozat <fcrozat@suse.com>

On Fri, Mar 23, 2012 at 03:03:51AM -0700, Christopher Li wrote:
> --- a/lib.c
> +++ b/lib.c
> @@ -224,6 +224,15 @@ static enum { STANDARD_C89,
>                STANDARD_GNU89,
>                STANDARD_GNU99, } standard = STANDARD_GNU89;
>  
> +#ifdef __x86_64__
> +#define ARCH_M64_DEFAULT 1
> +#else
> +#define ARCH_M64_DEFAULT 0
> +#endif

Ideally this should work on other 64-bit architectures as well.

Other than that, the rest of the patch looks reasonable.

- Josh Triplett
