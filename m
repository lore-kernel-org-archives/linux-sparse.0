From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Detect unused header files?
Date: Thu, 6 Aug 2009 14:16:45 +0200
Message-ID: <200908061416.46210.kdudka@redhat.com>
References: <20090728181803.GA20845@merkur.ravnborg.org> <e51f66da0908060414n62a34b89n322f516878567141@mail.gmail.com> <alpine.LFD.2.00.0908060716010.7946@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:53766 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755300AbZHFMPW (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 08:15:22 -0400
In-Reply-To: <alpine.LFD.2.00.0908060716010.7946@localhost>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu August 6 2009 13:17:02 Robert P. J. Day wrote:
> On Thu, 6 Aug 2009, Marko Kreen wrote:
> > On 8/5/09, Christopher Li <sparse@chrisli.org> wrote:
> > > On Thu, Jul 30, 2009 at 1:36 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
> > >  > Thanks for hacking this up!
> > >  >
> > >  > I will try it out during the weekend as work permits. Busy...
> > >
> > > Any updates?
> > >
> > >  It seems that top level header file including sub component
> > >  header file is very common practice, especially on big header
> > >  file. From the header file itself is not sufficient to determine
> > >  the included header file is a sub component or some thing
> > >  new.
> >
> > Could we have a flag to track top-level headers only?  So that
> > anything declared in sub-headers will be registered also under top
> > header file?  This seems more useful scanning mode for regular
> > user-space code.
>
>   has anyone tried cscout?
>
> http://www.spinellis.gr/cscout/

The homepage looks interesting, but where can I download its sources?

Kamil

