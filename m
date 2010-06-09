From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: help for using sparse
Date: Wed, 9 Jun 2010 09:10:59 -0700
Message-ID: <20100609161058.GA4204@feather>
References: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:47098 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0FIQLa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 12:11:30 -0400
Received: from mrelay4-v.mgt.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 4825A86192
	for <linux-sparse@vger.kernel.org>; Wed,  9 Jun 2010 18:11:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: bonneta <bonneta@ensimag.fr>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 09, 2010 at 05:09:54PM +0200, bonneta wrote:
> I am working on git, and i would like to apply sparse on its source code.
> 
> I've downloaded the source of sparse from its git repository, and compiled
> it successfully.
> 
> I've read the little documentation furnished with the code, but i didn't
> manage to apply sparse on the sources of git.
> 
> I've basically tried "sparse file.c", but it always returns with an error
> like :
> "git-compat-util.h:140:11: error: unable to open 'openssl/ssl.h'"
> or
> "builtin/blame.c:7:10: error: unable to open 'cache.h'"
> 
> I don't know how to resolve it...

These errors occur because you haven't supplied the full compiler
command-line that Git supplies in its build process, which includes
flags for include paths.

The script "cgcc", provided with sparse, provides the most convenient
way to integrate Sparse into an existing build system with minimal work.
Once you've done a "make install" of Sparse into a directory on your
$PATH (or just put the Sparse source directory on your $PATH), just do
"make CC=cgcc".

- Josh Triplett
