From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v4 12/13] Compiler Attributes: add Doc/process/programming-language.rst
Date: Sun, 9 Sep 2018 21:15:58 +0200
Message-ID: <CANiq72ngDkFUoROFGPL9A=CQ+X5e6R+pfxuBXWx9DWxoryGnTw@mail.gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
 <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com> <20180909121901.5a36d0fd@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180909121901.5a36d0fd@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

Hi Jonathan,

On Sun, Sep 9, 2018 at 8:19 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Sat,  8 Sep 2018 23:24:58 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
>>  Documentation/process/index.rst               |  1 +
>>  .../process/programming-language.rst          | 45 +++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>  create mode 100644 Documentation/process/programming-language.rst
>>
> So I have some overall thoughts on the documentation; my apologies for
> not getting to this until you got to v4...

No problem at all! :-)

>
> 1) I think the document is mistitled.  It's not really about the language
>    that the kernel used, it's about compiler attributes.  So I would make
>    both the name of the document and it introduction reflect that.

The idea here is to create a document explaining the programming
language that the kernel uses (which we hadn't), taking the chance to
describe the attributes (which in a way are extensions to the C
language); in the future expanding it with other (non-attribute)
extensions that we use. Of course, that is not done, but I thought
starting it was a nice idea (meant for people coming from a C
background that do not know the "dialect" used in Linux).

Also other kind of very commonly used macros and functions used
throughout the kernel could be summarized there as a summary for
newcomers (e.g. stuff like `printk`/`pr_*`, `likely`/`unlikely`,
`panic`, `EXPORT_SYMBOL`, `BUG_ON`/`WARN_ON`...), without writing full
documentation there (but pointing to where they are described, either
in the Docs or a source code if not).

What do you think?

>
> 2) This is an ideal opportunity to document what all of those attributes
>    actually mean.  I would guess that is the information many developers

I thought about that, but the issue is that compilers already describe
them: in the case of GCC, all of them are documented; some are in
clang; icc is not well documented --- see the previous threads about
this), so we would be duplicating that information (and it will become
outdated as compilers are released and improve the documentation).
This is the reason why the series removes most of the copy-pasted
documentation from gcc and instead supplies a link for each attribute
compiler_attributes.h to gcc & clang online docs.

>    will come here looking for, and they'll go away frustrated.  The ideal
>    thing to do, IMO, would be do say what each attribute means (rather
>    than just which compilers support it) in a DOC section in the new
>    compiler_attributes.h header, then use RST directives to pull all that
>    information into this document.

Initially my idea was to provide a table with the name and the links
to each compiler docs; so that it could be easily used. However, when
thinking about it, it seems that most people consulting such file
would come from the actual source code, so they would have to move
from there to the Doc/ file; so I did it the other way around (IIRC
Nick also mentioned his preference for keeping them in the source
code).

Now, the idea of keeping them in the header but pulling them to the
RST can be a good idea but I was unsure how to do it best. I took a
look at how other RST files did it (the pull), but I thought (maybe
wrongly) that I wouldn't be able to create a nice table (i.e. instead
it would be a long list of attributes, which most people will not use
-- and in my idea of a document describing all the extensions, it
would be taking most of the space), so I discarded it. I am not sure
about the future goals for the Docs/, so excuse me if I have the
completely wrong idea, but in a way, in the current state, I see the
kernel docs as articles/chapters/book on high-level concepts about the
kernel, rather than a technical reference (i.e. the source code with a
better formatting).

Thanks a lot for reviewing!

Cheers,
Miguel
