From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v4 00/13] Compiler Attributes
Date: Sun, 9 Sep 2018 18:52:12 +0200
Message-ID: <CANiq72k5GYk8x37mbWQQCLNyP82YcyzYOVunvL_2OO8ycqVTeg@mail.gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

Hi all,

On Sat, Sep 8, 2018 at 11:24 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> You can also fetch it from:
>
>   https://github.com/ojeda/linux/tree/compiler-attributes-v4

In case it helps, I have also rebased it onto next-20180907 at:

  https://github.com/ojeda/linux/tree/compiler-attributes-for-next

The only conflict was the removal of __aligned_largest in f3569fd613f6
("crypto: shash - Remove VLA usage in unaligned hashing").

(Luc's Reviewed-by is not included in that version)

Cheers,
Miguel
