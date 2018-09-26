From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Wed, 26 Sep 2018 11:03:03 -0700
Message-ID: <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com> <20180926180019.GD22824@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926180019.GD22824@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, sparse@chrisli.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, daniel.santos@pobox.com, chris@chris-wilson.co.uk, jani.nikula@intel.com
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 26, 2018 at 11:00 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Fri, Aug 31, 2018 at 09:46:02AM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 28, 2018 at 4:00 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
> > > >
> > > > Hello Nick,
> > > >
> > > > On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> > > > >>> Let's give up __compiletime_assert_fallback().  This commit does not
> > > > >>> change the current behavior since it just rips off the useless code.
> > > > >> Clang is not the only target audience of
> > > > >> __compiletime_assert_fallback().  Instead of ripping out something that
> > > > >> may benefit builds with gcc 4.2 and earlier, why not override its
> > > > > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> > > > > version to 4.6") that gcc < 4.6 is irrelevant.
> > > >
> > > > Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
> > > > I guess I would be OK with its removal, but I still think it would be
> > > > better if a similar mechanism to break the Clang build could be found.
> > >
> > > I'm consulting with our best language lawyers to see what combinations
> > > of _Static_assert and __builtin_constant_p would do the trick.
> >
> > Linus,
> > Can this patch be merged in the meantime?
>
> friendly ping :)
>
> With c5c2b11894f4 ("drm/i915: Warn against variable length arrays")
> clang raises plenty of vla warnings about
> __compiletime_error_fallback() in the i915 driver. Would be great to
> get rid of those without having to revert that commit.

I've been meaning to follow up on this, thanks Matthias.  I too would
really like this patch.

-- 
Thanks,
~Nick Desaulniers
