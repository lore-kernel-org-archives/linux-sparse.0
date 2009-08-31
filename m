From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: sparse segv with simple test
Date: Mon, 31 Aug 2009 13:53:54 -0700
Message-ID: <20090831205353.GA6239@josh-work.beaverton.ibm.com>
References: <20090830153202.4dc5c58c@s6510>
 <200908312012.37019.kdudka@redhat.com>
 <20090831114900.6887df23@nehalam>
 <200908312104.54990.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-v.mail.gandi.net ([217.70.178.77]:52125 "EHLO
	relay3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbZHaUx3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Aug 2009 16:53:29 -0400
Content-Disposition: inline
In-Reply-To: <200908312104.54990.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

On Mon, Aug 31, 2009 at 09:04:54PM +0200, Kamil Dudka wrote:
> On Monday 31 of August 2009 20:49:00 Stephen Hemminger wrote:
> > > But it might be good idea to implement such out-of-range detection ;-)
> >
> > Yes, I was looking to use more enum's in places where int was used in the
> > kernel. There were places where the interface expected a limit range of
> > values like network device transmit, but the interface was being misused
> > and caller was returning errno values.
> 
> Generally you can't simply check if the value is in a *range* since the enum 
> values could be non-continuous. You need to check for all continuous 
> sub-ranges or even for all values.
> 
> What about issuing a warning for any assignment of int value to enum? (as it 
> is already checked by a C++ compiler) Such places are IMHO always suspicious. 
> If you know what you are doing you can still cast it explicitly to avoid such 
> warning.

That seems quite sensible, and it even seems like something sparse
should warn about by default.

The reverse, warning about the assignment of an enum value to int, seems
useful as well, but sparse shouldn't issue that warning by default
because a lot of code just uses enum to define constants.

Distinguishing between anonymous and named enums seems useful as well.
An anonymous enum just creates some named constants but doesn't create a
type to use them with, so assigning those constants to int shouldn't
generate a warning.  (Corner case: "enum { ... } foo;".)

- Josh Triplett
