From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 12/13] Compiler Attributes: add
 Doc/process/programming-language.rst
Date: Sun, 9 Sep 2018 12:19:01 -0600
Message-ID: <20180909121901.5a36d0fd@lwn.net>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
        <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat,  8 Sep 2018 23:24:58 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>  Documentation/process/index.rst               |  1 +
>  .../process/programming-language.rst          | 45 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/process/programming-language.rst
> 
So I have some overall thoughts on the documentation; my apologies for
not getting to this until you got to v4...

1) I think the document is mistitled.  It's not really about the language
   that the kernel used, it's about compiler attributes.  So I would make
   both the name of the document and it introduction reflect that.

2) This is an ideal opportunity to document what all of those attributes
   actually mean.  I would guess that is the information many developers
   will come here looking for, and they'll go away frustrated.  The ideal
   thing to do, IMO, would be do say what each attribute means (rather
   than just which compilers support it) in a DOC section in the new
   compiler_attributes.h header, then use RST directives to pull all that
   information into this document.

Thanks,

jon
