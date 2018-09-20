From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 18:11:30 +0200
Message-ID: <CANiq72mB3O-bogor8hAeST4yexXFyYswfTXpaAyqE+KWRC=kVA@mail.gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica> <20180920072205.GC11963@kroah.com> <20180920073650.GA6001@nautica>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920073650.GA6001@nautica>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-sparse@vger.kernel.org

On Thu, Sep 20, 2018 at 9:36 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Greg Kroah-Hartman wrote on Thu, Sep 20, 2018:
>> Why not just route these through Andrew?  He takes lots of stuff like
>> this for this very reason.
>
> That works for me (although it might have helped if Andrew had been in
> Cc at any point in this discussion...), but part of the discussion was

Cc'ing him (and Luc too) now. I have put a bigger list of Cc people
for v5 (and will simply Cc everyone for all patches).

> about seriously maintaining these files, and Miguel stepped up to help
> with that so it could make sense to have his own tree.
>
>
> Frankly, after this whole episode I'd find quite helpful if "compiler
> stuff" (or headers maintainance in general) were to grow its own mailing
> list and start being considered like a proper component of the kernel.

Yeah, the compiler headers have seen quite some changes in the last ~3
years compared to the time before so it might be a good idea:

  https://ojeda.io/uploads/compiler-headers-file-size.png

>> It does impact quite a few people, and it's neigh-impossible to review
> this stuff as things are right now with a hand-picked list of CCs, no
> matter how large it is -- I don't mind if it goes in -next through its
> own branch or through Andrew, but a proper place where folks interested
> in these could subscribe and test/review the patches would be awesome.
>

I guess compiler folks would like that too.

Cheers,
Miguel
