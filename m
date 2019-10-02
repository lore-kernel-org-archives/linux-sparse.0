From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Many unexpected warnings with current sparse
Date: Wed, 2 Oct 2019 03:35:38 +0200
Message-ID: <20191002013537.2bfopy3ke5kkmqep@desk.local>
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
 <20191001231017.67txq4dhrvhyzbu5@desk.local>
 <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
 <20191002001859.qeyo3btl7tosz3vo@desk.local>
 <CAH2r5mtzAgcJTrGuderq4DEHBXtPujcQ8DWJUzM0w=hHX8WbJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH2r5mtzAgcJTrGuderq4DEHBXtPujcQ8DWJUzM0w=hHX8WbJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: Paulo Alcantara <paulo@paulo.ac>, David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Oct 01, 2019 at 08:24:45PM -0500, Steve French wrote:
> On Tue, Oct 1, 2019 at 7:19 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Tue, Oct 01, 2019 at 06:14:23PM -0500, Steve French wrote:
> > > It may be related to the following sparse make warning:
> > >
> > > No rule to make target
> > > '/usr/include/x86_64-linux-gnu/bits/huge_val.h', needed by
> > > 'sparse-llvm.o'
> > >
> > > I don't see huge_val.h in the Ubuntu 19 version of libc6-dev
> >
> > Yes, I've been bitten myself by this. It's fixed since a little while.
> > So, just doing a clean build or removing all the deps (.*.d)
> > should allow you to build sparse.
> >
> > I've verified the problem with asm and __inline in quota.h:
> > it's autodetected by kconfig (CC_HAS_ASM_INLINE) so the exact config
> > doesn't matter (only gcc's version does) but in all cases recent
> > versions of sparse don't have a problem with it
> 
> Removed the dependencies and rebuilt as you suggested and it worked ...
> and even better ... with the noise removed I now see two real bugs

Ahh, good!

> (endian conversion missing on two lines) and only one possible problem
> with sparse/gcc itself
> 
> Sparse now flags this line from one of Paulo's DFS features merged last year:
> 
>       struct smb_vol fake_vol = {0};
> 
> with
> 
>       "warning: Using plain integer as NULL pointer"
> 
> What is the recommended way to initialize a struct to avoid the sparse warning?

Well, personally, I simply use '{}'. GCC and sparse are happy with it but, IIRC,
it's not allowed by the standard...

> And what about the "namespace" warnings from the fscache (cache.o)
> code that now show up?  I hadn't seen those before.
> Any easy way to remove them?
> 
> "WARNING: module cifs uses symbol sigprocmask from namespace
> fs/cifs/cache.o: $(deps_/home/sfrench/cifs-2.6/fs/cifs/cache.o), but
> does not import it."

This one is not from sparse, it's from modpost (see EXPORT_SYMBOL_NS).

Cheers,
-- Luc
