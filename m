From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: Detect unused header files?
Date: Thu, 6 Aug 2009 08:15:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908060813460.8569@localhost>
References: <20090728181803.GA20845@merkur.ravnborg.org> <e51f66da0908060414n62a34b89n322f516878567141@mail.gmail.com> <alpine.LFD.2.00.0908060716010.7946@localhost> <200908061416.46210.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:53018 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZHFMSA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 08:18:00 -0400
In-Reply-To: <200908061416.46210.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu, 6 Aug 2009, Kamil Dudka wrote:

> On Thu August 6 2009 13:17:02 Robert P. J. Day wrote:
> > On Thu, 6 Aug 2009, Marko Kreen wrote:
> > > On 8/5/09, Christopher Li <sparse@chrisli.org> wrote:
> > > > On Thu, Jul 30, 2009 at 1:36 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
> > > >  > Thanks for hacking this up!
> > > >  >
> > > >  > I will try it out during the weekend as work permits. Busy...
> > > >
> > > > Any updates?
> > > >
> > > >  It seems that top level header file including sub component
> > > >  header file is very common practice, especially on big header
> > > >  file. From the header file itself is not sufficient to determine
> > > >  the included header file is a sub component or some thing
> > > >  new.
> > >
> > > Could we have a flag to track top-level headers only?  So that
> > > anything declared in sub-headers will be registered also under top
> > > header file?  This seems more useful scanning mode for regular
> > > user-space code.
> >
> >   has anyone tried cscout?
> >
> > http://www.spinellis.gr/cscout/
>
> The homepage looks interesting, but where can I download its sources?

http://www.spinellis.gr/cscout/download.html

i grabbed a copy of it a few days ago, i just haven't had time to set
it up.  i mention it since one of the things it claims to do is -- ta
da! -- identify unused header files.  but it appears to take some
careful configuration.  i'd like to see someone config it to scan the
current source tree, i just don't think i have the time at the moment.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
"Kernel Newbie Corner" column @ linux.com:          http://cli.gs/WG6WYX
========================================================================
