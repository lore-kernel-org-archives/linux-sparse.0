From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Sun, 21 Oct 2018 18:27:12 -0400
Message-ID: <20181021222712.GI1617@thunk.org>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>David
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> From the GCC manual:
> 
>   fallthrough
> 
>     The fallthrough attribute with a null statement serves as a
>     fallthrough statement. It hints to the compiler that a statement
>     that falls through to another case label, or user-defined label
>     in a switch statement is intentional and thus the -Wimplicit-fallthrough
>     warning must not trigger. The fallthrough attribute may appear
>     at most once in each attribute list, and may not be mixed with
>     other attributes. It can only be used in a switch statement
>     (the compiler will issue an error otherwise), after a preceding
>     statement and before a logically succeeding case label,
>     or user-defined label.
> 
>   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html

Do we know if coverity understands the fallthrough attribute?  One of
the reasons why I started using /* fallthrough */ is because it kept
Coverity happy.

If the conversion from /* fallthrough */ to the __fallthrough__
attribute means that we start gethting a lot of Coverity warnings,
that would be unfortunate.  OTOH, if this is getting standardized,
maybe we can get Coverity to understand this attribute?

						- Ted
