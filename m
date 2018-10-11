From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Thu, 11 Oct 2018 11:48:59 +0900
Message-ID: <CAK7LNATXiJkXa4bfrCMb-kuWrn2gg-7jJg3qT3UR6HVSpC3Y3w@mail.gmail.com>
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
 <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
 <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
 <CANiq72nGrNMEqnPrxGXCp_iKf1_FuJLMvoV1+bbfYYCKnfTPVw@mail.gmail.com> <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Joel Stanley <joel@jms.id.au>, Nick Desaulniers <ndesaulniers@google.com>, Andrew Morton <akpm@linux-foundation.org>, Matthias Kaehlcke <mka@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Santos <daniel.santos@pobox.com>, Chris Wilson <chris@chris-wilson.co.uk>, jani.nikula@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-sparse@vger.kernel.org

On Wed, Oct 10, 2018 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 10, 2018 at 12:03 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Wed, Oct 10, 2018 at 8:12 AM Joel Stanley <joel@jms.id.au> wrote:
> >>
> >> On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
> >> >
> >> > Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?
> >>
> >> clang built -next is blowing up now that Kees' -Wvla patch has been
> >> included. This patch fixes it.
> >>
> >> Kees, perhaps it should go in your tree along side of the -Wvla patch
> >> if no one else wants to take it?
> >>
> >
> > I can take it along in the compiler attributes tree, since that
> > touches the compiler*.h stuff. Although that would make it
> > not-only-attributes, i.e. slightly lying :-)
>
> Oh, I had assumed Masahiro was going to carry it.

No, I am not.

Putting all sort of things into kbuild basket
is painful for me.



> If that's not true,
> sure I'll pick it up as part of my VLA "series".


-- 
Best Regards
Masahiro Yamada
