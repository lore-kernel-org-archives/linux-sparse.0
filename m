From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Sat, 24 Jan 2015 21:39:23 +0100
Message-ID: <20150124203922.GA52862@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
 <20150124012958.GB28468@thin>
 <20150124112705.GA47109@macpro.local>
 <20150124201949.GA1642@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:60796 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbAXUj2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 24 Jan 2015 15:39:28 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so3310006wiv.0
        for <linux-sparse@vger.kernel.org>; Sat, 24 Jan 2015 12:39:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150124201949.GA1642@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sam Ravnborg <sam@ravnborg.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jan 24, 2015 at 12:19:50PM -0800, Josh Triplett wrote:
> On Sat, Jan 24, 2015 at 12:27:06PM +0100, Luc Van Oostenryck wrote:
> > On Fri, Jan 23, 2015 at 05:29:58PM -0800, Josh Triplett wrote:
> > > On Sat, Jan 24, 2015 at 12:59:35AM +0100, Luc Van Oostenryck wrote:
> > > > Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
> > > > 
> > > > This macro expands to sequential integral values starting from 0,
> > > > and this for each top-level source file.
> > > > 
> > > > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > > 
> > > counter3.c seems like a bit of an abuse of the test suite framework, but
> > > I don't have a better suggestion.
> > > 
> > > Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> > 
> > Yes, I know ...
> > 
> > Would the following change to the test-suite (introducing tags to separate input sections)
> > and the corresponding test be more OK ?
> 
> Interesting idea!  That would also allow consolidating tests that
> require include files into a single test file, if it's possible to
> #include "$file1"; for instance, pragma-once.c could avoid recursing if
> the test fails.
> 
> I'll leave it to others to decide if this seems like a direction the
> test suite should expand to cover, or if for this single case counter3.c
> should just include other tests as your previous patch did.
> 
> - Josh Triplett
> --

Yes, it's fairly easy to add. In fact ... yesterday I had a version that
did that but I removed it because I found it a bit hackish and it was
not needed.


Luc
