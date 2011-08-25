From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: sparse and multiarch include paths
Date: Wed, 24 Aug 2011 20:16:02 -0700
Message-ID: <20110825031602.GA1944@leaf>
References: <20110824214244.GA12248@leaf>
 <87zkiy1ld2.fsf@ludovic-brenta.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55243 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1HYDQK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Aug 2011 23:16:10 -0400
Content-Disposition: inline
In-Reply-To: <87zkiy1ld2.fsf@ludovic-brenta.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ludovic Brenta <ludovic@ludovic-brenta.org>
Cc: linux-sparse@vger.kernel.org, debian-gcc@lists.debian.org, multiarch-devel@lists.alioth.debian.org

On Thu, Aug 25, 2011 at 12:43:37AM +0200, Ludovic Brenta wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > When trying to use sparse on some low-level userspace code, I ran into
> > the following error:
> >
> > /usr/include/bits/socket.h:381:11: error: unable to open 'asm/socket.h'
> 
> See http://bugs.debian.org/638418
> 
> Hope this helps

Thanks!  That does seem to explain the problem; I removed and
reinstalled gcc-multilib, and now I have a /usr/include/asm symlink and
sparse seems happy.

- Josh Triplett
