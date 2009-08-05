From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Detect unused header files?
Date: Wed, 5 Aug 2009 08:12:23 +0200
Message-ID: <20090805061223.GA2861@merkur.ravnborg.org>
References: <20090728181803.GA20845@merkur.ravnborg.org> <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com> <alpine.LFD.2.00.0907281634400.3974@localhost> <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com> <20090728210404.GA21187@merkur.ravnborg.org> <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com> <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com> <20090730203633.GA28838@merkur.ravnborg.org> <70318cbf0908041449u4ce5ab30w6700a7081aa4909c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:36050 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbZHEGMY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Aug 2009 02:12:24 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0908041449u4ce5ab30w6700a7081aa4909c@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 04, 2009 at 02:49:27PM -0700, Christopher Li wrote:
> On Thu, Jul 30, 2009 at 1:36 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
> > Thanks for hacking this up!
> >
> > I will try it out during the weekend as work permits. Busy...
> 
> Any updates?
Sorry - but caught up with day-time job.
 
> It seems that top level header file including sub component
> header file is very common practice, especially on big header
> file. From the header file itself is not sufficient to determine
> the included header file is a sub component or some thing
> new.
In the exported linux-kernel headers this is not common practice - so we will not
be caught by this.
But for general application programming it is useless.

	Sam
