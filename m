From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Wed, 26 Sep 2018 12:29:19 -0700
Message-ID: <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926190303.GA18293@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, sparse@chrisli.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, daniel.santos@pobox.com, chris@chris-wilson.co.uk, jani.nikula@intel.com, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 26, 2018 at 12:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 26, 2018 at 11:45:19AM -0700, Kees Cook wrote:
> > On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > I'm not digging up a compiler.h patch from a web site and adding it to
> > > the tree this late in the release cycle.  Especially given that it
> > > hasn't had any testing anywhere...
> >
> > Good point about it not living in -next.
> >
> > Who should be carrying these sorts of patches? In the past it's been
> > Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?
>
> Either is fine with me, as long as it isn't one of my trees :)
>
> thanks,
>
> greg k-h

Besides, I think we want the v2: https://lkml.org/lkml/2018/8/25/103
-- 
Thanks,
~Nick Desaulniers
