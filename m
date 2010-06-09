From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: help for using sparse
Date: Wed, 9 Jun 2010 20:48:11 +0200
Message-ID: <20100609184811.GA20200@merkur.ravnborg.org>
References: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:53022 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085Ab0FISsN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 14:48:13 -0400
Content-Disposition: inline
In-Reply-To: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: bonneta <bonneta@ensimag.fr>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 09, 2010 at 05:09:54PM +0200, bonneta wrote:
> Hello,
> 
> I am working on git, and i would like to apply sparse on its source code.
> 
> I've downloaded the source of sparse from its git repository, and compiled
> it successfully.
> 
> I've read the little documentation furnished with the code, but i didn't
> manage to apply sparse on the sources of git.

It looks like git already supports sparse.

Try "make check"

Try to search for "sparse" in the makefile of git.

	Sam
