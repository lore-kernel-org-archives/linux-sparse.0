From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] Fix handling of ident-less declarations
Date: Sat, 14 Feb 2009 21:30:32 +0000
Message-ID: <20090214213032.GQ28946@ZenIV.linux.org.uk>
References: <E1LYJZx-0001ls-Nn@ZenIV.linux.org.uk> <70318cbf0902141045q2552f1aetdd0ba0e462a21bad@mail.gmail.com> <20090214190836.GO28946@ZenIV.linux.org.uk> <20090214203154.GP28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55475 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbZBNVae (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 16:30:34 -0500
Content-Disposition: inline
In-Reply-To: <20090214203154.GP28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, Feb 14, 2009 at 08:31:54PM +0000, Al Viro wrote:
> On Sat, Feb 14, 2009 at 07:08:36PM +0000, Al Viro wrote:
> > On Sat, Feb 14, 2009 at 10:45:41AM -0800, Christopher Li wrote:
> > > On Sat, Feb 14, 2009 at 4:25 AM, Al Viro <viro@ftp.linux.org.uk> wrote:
> > > >
> > > > The rule for ident-less declaration is
> > > 
> > > wow, great.
> > > 
> > > The series applies to the tree fine. First impression of the series
> > > looks fine. I am still working on it.
> > > 
> > > Thanks for the patches. BTW, this is not the "lazy type evaluation"
> > > you are talking about right?
> > 
> > No, just the first batch of declaration parser fixes...  The next group is
> > about separating ctype-as-part-of-symbol from ctype-as-parser-state uses.
> > After that - getting declaration_specifiers() to sane shape, which, BTW,
> > will relieve the situation with mode bits.  Then -  cleaning up the type
> > handling...
> 
> BTW, I wonder whether if it would be better to just scan for the end
> of attributes after ( when we are deciding whether it's a function or
> nested declarator, leaving the actual handling of these guys to after
> the decision.  The thing is, unlike gcc we have the token list anyway,
> and it's easier to not bother with passing that crap to parameter_type_list(),
> etc.
> 
> I'll try to do that and see what falls out; potentially that replaces
> 7/7 in this series.

... no, it doesn't ;-/  Too much PITA with error recovery, so the original
version still stands.  Alas.
