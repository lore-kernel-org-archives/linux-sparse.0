From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Many unexpected warnings with current sparse
Date: Wed, 2 Oct 2019 02:19:00 +0200
Message-ID: <20191002001859.qeyo3btl7tosz3vo@desk.local>
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
 <20191001231017.67txq4dhrvhyzbu5@desk.local>
 <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Oct 01, 2019 at 06:14:23PM -0500, Steve French wrote:
> It may be related to the following sparse make warning:
> 
> No rule to make target
> '/usr/include/x86_64-linux-gnu/bits/huge_val.h', needed by
> 'sparse-llvm.o'
> 
> I don't see huge_val.h in the Ubuntu 19 version of libc6-dev

Yes, I've been bitten myself by this. It's fixed since a little while.
So, just doing a clean build or removing all the deps (.*.d)
should allow you to build sparse.
 
I've verified the problem with asm and __inline in quota.h:
it's autodetected by kconfig (CC_HAS_ASM_INLINE) so the exact config
doesn't matter (only gcc's version does) but in all cases recent
versions of sparse don't have a problem with it (an upstream version
of `sparse --version` should return "v0.6.1-rc1-37-gd466a0281").

Best regards,
-- Luc
