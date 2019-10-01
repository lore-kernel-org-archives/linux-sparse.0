From: Steve French <smfrench@gmail.com>
Subject: Re: Many unexpected warnings with current sparse
Date: Tue, 1 Oct 2019 18:14:23 -0500
Message-ID: <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
 <20191001231017.67txq4dhrvhyzbu5@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001231017.67txq4dhrvhyzbu5@desk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, sparse@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

It may be related to the following sparse make warning:

No rule to make target
'/usr/include/x86_64-linux-gnu/bits/huge_val.h', needed by
'sparse-llvm.o'

I don't see huge_val.h in the Ubuntu 19 version of libc6-dev

Will send you the kernel config - but I am using the default one from
the Ubuntu mainline download of 5.4-rc1

On Tue, Oct 1, 2019 at 6:10 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Tue, Oct 01, 2019 at 11:28:16AM -0500, Steve French wrote:
> > Updated sparse to get rid of some unneeded kernel sparse check
> > warnings but now get many more
> >
> > I get 100s of warnings similar to
> >
> > ./include/linux/quota.h:114:17: error: Expected ( after asm
> > ./include/linux/quota.h:114:17: error: got __inline
> >
> > but that is simply
> >         default:
> >                 BUG();
>
> Hi,
>
> I don't see this on v5.4-rc1 with defconfig or allyesconfig and
> sparse's current version. Any sparse's version since roughly
> mid-December should give the same result.
>
> If you're using an older version of sparse, please upgrade.
> Otherwise, please send me your config so that I can take a look at it.
>
>
> Best regards,
> -- Luc Van Oostenryck



-- 
Thanks,

Steve
