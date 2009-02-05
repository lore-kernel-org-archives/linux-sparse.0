From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Thu, 5 Feb 2009 23:22:49 +0000
Message-ID: <20090205232249.GQ28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com> <20090203041317.GH28946@ZenIV.linux.org.uk> <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com> <498B3435.8010506@knosof.co.uk> <20090205202811.GO28946@ZenIV.linux.org.uk> <70318cbf0902051441m3b015affvc33003ac6a733f18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60439 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZBEXWv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 18:22:51 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0902051441m3b015affvc33003ac6a733f18@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Derek M Jones <derek@knosof.co.uk>, linux-sparse@vger.kernel.org

On Thu, Feb 05, 2009 at 02:41:00PM -0800, Christopher Li wrote:

> Can you elaborate the referential transparency? I currently have a vague
> idea of what you are trying to do. Where should I start if I am going
> to turn the idea into code. Should we delay the detail of type
> information until evaluate stage?

Basically, "replace equal with equal".  I.e. whatever we do with struct
symbol that might be visible to somebody, we should not change the
interpretation of type for *any* struct symbol, including ones that
might refer to that one.

Take a look at uninlining for a nice example of the fallout you get
when that property doesn't hold.  We cannibalize struct expression
during evaluation a _lot_, so we have to be bloody careful about what
we share and what we must copy.

For struct expression we do that in a lot of places and it's probably
worth to keep doing due to memory footprint concerns.  For types
we can avoid that.

As for the laziness - yes, that's what classify_type() et.al. is about.
We want to do exactly as little as possible; basically, *all* type
node evaluation (aka examining) should be demand-driven.  It mostly
holds, but we definitely could be lazier, e.g. in qualifier-related
stuff.

I'll do a more complete braindump (ideally - along with the declaration-parsing
patchset, so that this work could really start) once I dig myself from
under the !@#!@#!@# patch and mail piles elsewhere a bit.

			Al, terminally annoyed by the size of backlog ;-/
