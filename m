From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Wed, 10 Oct 2018 16:40:24 +1030
Message-ID: <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
 <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Andrew Morton <akpm@linux-foundation.org>, mka@chromium.org, Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, sparse@chrisli.org, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.santos@pobox.com, chris@chris-wilson.co.uk, jani.nikula@intel.com, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-sparse@vger.kernel.org

On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 26, 2018 at 12:29 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Wed, Sep 26, 2018 at 12:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Wed, Sep 26, 2018 at 11:45:19AM -0700, Kees Cook wrote:
> >> > On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > > I'm not digging up a compiler.h patch from a web site and adding it to
> >> > > the tree this late in the release cycle.  Especially given that it
> >> > > hasn't had any testing anywhere...
> >> >
> >> > Good point about it not living in -next.
> >> >
> >> > Who should be carrying these sorts of patches? In the past it's been
> >> > Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?
> >>
> >> Either is fine with me, as long as it isn't one of my trees :)
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> > Besides, I think we want the v2: https://lkml.org/lkml/2018/8/25/103
>
> Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?

clang built -next is blowing up now that Kees' -Wvla patch has been
included. This patch fixes it.

Kees, perhaps it should go in your tree along side of the -Wvla patch
if no one else wants to take it?

Cheers,

Joel
