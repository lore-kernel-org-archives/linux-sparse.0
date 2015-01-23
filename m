From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Fri, 23 Jan 2015 23:28:16 +0100
Message-ID: <20150123222816.GB691@ravnborg.org>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:40415 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbbAWWdY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 17:33:24 -0500
Content-Disposition: inline
In-Reply-To: <20150123222332.GB42179@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jan 23, 2015 at 11:23:32PM +0100, Luc Van Oostenryck wrote:
> On Fri, Jan 23, 2015 at 08:40:17AM -0800, Christopher Li wrote:
> > On Thu, Jan 22, 2015 at 12:31 PM, Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> > > Linus, Christopher,
> > >
> > > Commit  0f25c6a78e08fdc15af5e599d836fa24349c042f ("Add warning about duplicate initializers") has a false positive on arch/s390/kvm/kvm-s390.c
> > >
> > >   CHECK   arch/s390/kvm/kvm-s390.c
> > > arch/s390/kvm/kvm-s390.c:1823:1: error: symbol '__UNIQUE_ID_alias__COUNTER__' has multiple initializers (originally initialized at arch/s390/kvm/kvm-s390.c:1822)
> > 
> > Search the "__COUNTER__" macro shows that:
> > https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
> > 
> > __COUNTER__This macro expands to sequential integral values starting
> > from 0. In conjunction with the ## operator, this provides a
> > convenient means to generate unique identifiers. Care must be taken to
> > ensure that __COUNTER__ is not expanded prior to inclusion of
> > precompiled headers which use it. Otherwise, the precompiled headers
> > will not be used.
> > 
> > I think sparse haven't implement the __COUNTER__ macro. That is why it emit the
> > error on duplicate entry.
> > 
> > Chris
> > --
> 
> 
> The following patch should fix that.

Seems we were working on this in parallel :-)
> 
> 
> Luc
> 
> 
> Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
