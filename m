From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v4 00/13] Compiler Attributes
Date: Sun, 9 Sep 2018 17:21:04 +0200
Message-ID: <CANiq72kSvH-QgY7rf5VWt+NnmxX8E6h6dt2LEyz_xGO8cZ835Q@mail.gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com> <20180909080200.xn7z4gctf2vrqzst@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180909080200.xn7z4gctf2vrqzst@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

Hi Luc,

On Sun, Sep 9, 2018 at 10:02 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Sep 08, 2018 at 11:24:46PM +0200, Miguel Ojeda wrote:
>> The Compiler Attributes series is an effort to disentangle
>> the include/linux/compiler*.h headers and bring them up to date.
>>
>> The main idea behind the series is to use feature checking macros
>> (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
>> which are compiler-agnostic (so they can be shared, reducing the size
>> of compiler-specific headers) and version-agnostic.
>>
>> Other related improvements have been performed in the headers as well,
>> which on top of the use of __has_attribute it has amounted to a significant
>> simplification of these headers (e.g. GCC_VERSION is now only guarding 4
>> non-attribute macros).
>>
>> This series should also help the efforts to support compiling the kernel
>> with clang and icc. A fair amount of documentation and comments have also
>> been added, clarified or removed; and the headers are now more readable,
>> which should help kernel developers in general.
>>
>> The series was triggered due to the move to gcc >= 4.6. In turn, this series
>> has also triggered Sparse to gain the ability to recognize __has_attribute
>> on its own.
>>
>> You can also fetch it from:
>>
>>   https://github.com/ojeda/linux/tree/compiler-attributes-v4
>>
>> Enjoy!
>
> It's a nice and welcomed cleanup!
> Everything look good to me, so feel free to add my
>     Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks a lot for the review! :-)

Cheers,
Miguel
