From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 13:07:34 +0200
Message-ID: <CANiq72=ioYcRA-yq38+Z4i6iVDNm6C2-+b4feRmnvEiekuR7dA@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
 <20181022102743.nua5fgbscyeymzal@mwanda> <1474d995-1b5a-2efb-f077-33eb4a5d9e31@petrovitsch.priv.at>
 <20181022105314.j6djkrpwbnokhai5@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022105314.j6djkrpwbnokhai5@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan <dan.carpenter@oracle.com>
Cc: bernd@petrovitsch.priv.at, Ted Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 12:54 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Doing both is super ugly.  Let's just do comments until Eclipse gets
> updated.
>
> I had wanted to move to the attribute because that would simplify things
> in Smatch but it's not a huge deal to delay for another year.

I can re-send them later on, no problem. On the other hand, doing the
changes will push tools to get updated sooner ;-)

If tools were doing something as fancy as comment parsing for
diagnostics, they should have been updated with the attribute support
(either gcc's or C++17's) -- it has been more than a year now since
gcc 7.1 and the C++17 final draft. (Note that this does not apply for
things like clang, since they weren't doing comment parsing to begin
with.)

Cheers,
Miguel
