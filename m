From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Wed, 26 Sep 2018 11:45:19 -0700
Message-ID: <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com> <20180926184259.GB14797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926184259.GB14797@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Matthias Kaehlcke <mka@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Santos <daniel.santos@pobox.com>, Chris Wilson <chris@chris-wilson.co.uk>, Jani Nikula <jani.nikula@intel.com>
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> I'm not digging up a compiler.h patch from a web site and adding it to
> the tree this late in the release cycle.  Especially given that it
> hasn't had any testing anywhere...

Good point about it not living in -next.

Who should be carrying these sorts of patches? In the past it's been
Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?

-Kees

-- 
Kees Cook
Pixel Security
