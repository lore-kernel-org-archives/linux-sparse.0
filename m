From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv2] Rename -Wall to Wsparse-all, so it doesn't get
 turned on unintentionally
Date: Sun, 11 Oct 2009 23:25:00 -0700
Message-ID: <20091012062457.GA6370@feather>
References: <20091011224618.GA3963@feather>
 <70318cbf0910112246w3cdb386fjc12f0be4ff135220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:51442 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZJLGhc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Oct 2009 02:37:32 -0400
Received: from relay1-v.mail.gandi.net (relay1-v.mail.gandi.net [217.70.178.75])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 8CBA639915
	for <linux-sparse@vger.kernel.org>; Mon, 12 Oct 2009 08:26:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <70318cbf0910112246w3cdb386fjc12f0be4ff135220@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Oct 11, 2009 at 10:46:25PM -0700, Christopher Li wrote:
> On Sun, Oct 11, 2009 at 3:47 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > v2: Update cgcc and remove unnecessary (and now ignored) -Wall from a
> > test case.
> 
> Applied. BTW, what do you think about moving the logic from cgcc into
> sparse directly?

Definitely a good idea.

The logic in cgcc seems to fall in two main categories:
architecture-specific code and code to launch the C compiler.  The
former should definitely live in sparse itself, because otherwise sparse
doesn't have all the proper built-in definitions when launched directly;
I'd like to *avoid* the GCC approach of only supporting one architecture
(or architecture family) at a time, though, and instead let the caller
specify any architecture sparse supports.  As for launching the
compiler, it would prove fairly straightforward for sparse to strip any
sparse-specific warning options from its command line and then launch
$CC; in fact, if sparse did so right before exiting, it could just call
exec and avoid the need to fork.

- Josh Triplett
