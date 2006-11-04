From: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: Official releases?
Date: Sat, 04 Nov 2006 00:09:25 -0600
Message-ID: <1162620565.3139.100.camel@vader.jdub.homelinux.org>
References: <1162307025.11613.1.camel@zod.rchland.ibm.com>
	 <4547B3C7.5030608@freedesktop.org>
	 <1162327518.26960.0.camel@zod.rchland.ibm.com>
	 <454C222D.8000901@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 67-41-71-127.roch.qwest.net ([67.41.71.127]:63981 "EHLO
	jdub.homelinux.org") by vger.kernel.org with ESMTP id S932365AbWKDGKd
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Nov 2006 01:10:33 -0500
In-Reply-To: <454C222D.8000901@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Fri, 2006-11-03 at 21:16 -0800, Josh Triplett wrote:
> Josh Boyer wrote:
> > On Tue, 2006-10-31 at 12:36 -0800, Josh Triplett wrote:
> >> Josh Boyer wrote:
> >>> I'm just curious if anyone is ever really going to do an "official"
> >>> release of sparse.  We've got daily snapshots provided by Dave Jones,
> >>> and git of course, but will an official release tarball with shiny
> >>> version numbers and everything be created?
> >> Since sparse doesn't use any autofoolery, and doesn't include a version number
> >> in the source anywhere, making a release should just require running git tag
> >> and git archive, and putting the resulting tarball up in an official location.
> >> As far as version numbering, it seems reasonable to use the former kernel
> >> versioning system: major.oddeven.revision, starting from something like 0.1.0,
> >> and keeping major version 0 until sparse can comfortably provide some
> >> guarantee of backward compatibility for sparse extensions.  Thus, periodic
> >> releases (0.1.1, 0.1.2, ...) wouldn't take much effort at all, and eventually
> >> calling one "stable" (0.2.0, with crash-fixes an similar backported to produce
> >> 0.2.1, 0.2.2, ...) would mostly consist of a judgement call.
> > 
> > Great.  Did you see Linus' email suggesting that I ask you to do
> > this? :)
> 
> I did, and I plan to roll a release this weekend.

Excellent.  Thanks much!

josh
