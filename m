From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 14:18:24 +0200
Message-ID: <CANiq72nkQBYnDM2QLKJvAaMJ6iCB=oXg1UZRbpXbf732f1OyZw@mail.gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica> <20180920072205.GC11963@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920072205.GC11963@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Sep 20, 2018 at 9:22 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> For this instance, I think we should just revert the offending patch,
> which should resolve the issue for everyone and then you can try to redo
> your series to get it right the next time.
>
> Sound good?

On one hand, "reverting & retrying" is a good default policy. On the
other hand, we are already in -rc4 (i.e. we lose the testing done
until now --- note that in this case the revert implies a global
change). So whatever makes you guys feel more comfortable.

Cheers,
Miguel
