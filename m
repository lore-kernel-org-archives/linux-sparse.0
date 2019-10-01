From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Many unexpected warnings with current sparse
Date: Wed, 2 Oct 2019 01:10:18 +0200
Message-ID: <20191001231017.67txq4dhrvhyzbu5@desk.local>
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, sparse@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Oct 01, 2019 at 11:28:16AM -0500, Steve French wrote:
> Updated sparse to get rid of some unneeded kernel sparse check
> warnings but now get many more
> 
> I get 100s of warnings similar to
> 
> ./include/linux/quota.h:114:17: error: Expected ( after asm
> ./include/linux/quota.h:114:17: error: got __inline
> 
> but that is simply
>         default:
>                 BUG();

Hi,

I don't see this on v5.4-rc1 with defconfig or allyesconfig and
sparse's current version. Any sparse's version since roughly
mid-December should give the same result.

If you're using an older version of sparse, please upgrade.
Otherwise, please send me your config so that I can take a look at it.


Best regards,
-- Luc Van Oostenryck
