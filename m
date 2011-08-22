From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 4/5] sparse, i386: Fix boolean bit size
Date: Mon, 22 Aug 2011 08:28:47 -0700
Message-ID: <20110822152847.GC21442@leaf>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
 <1314021451-24808-4-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33537 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab1HVP2z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 11:28:55 -0400
Content-Disposition: inline
In-Reply-To: <1314021451-24808-4-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 22, 2011 at 04:57:30PM +0300, Pekka Enberg wrote:
> The value of 'ctype->bit_size' is set to 1 for booleans which confuses the i386
> backend:
> 
>   ./compile allocate.c
>   compile: compile-i386.c:1406: emit_binop: Assertion `0' failed.
>   Aborted
> 
> Looking at the code, we assume that "bit_size / 8" gives a sane result on
> various places. This patch fixes the problem by bumping bit_size to 8 for
> booleans. This also makes sizeof(_Bool) return 1 which is consistent with what
> GCC 4.4.3, for example, does.

Seems reasonable; that would make it consistent with the behavior of
structs or arrays of bool, at least in GCC.  As far as I know, GCC
doesn't have any logic to attempt to compress a bool down to a single
bit of storage.

- Josh Triplett
