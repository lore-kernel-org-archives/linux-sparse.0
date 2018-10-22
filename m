From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 10:26:00 -0700
Message-ID: <CAKwvOd=SUTqfASs-_5--GYFx79bETMcjCzBacw5ujMsxGwU5SQ@mail.gmail.com>
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
To: dan.carpenter@oracle.com
Cc: bernd@petrovitsch.priv.at, Theodore Ts'o <tytso@mit.edu>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org, mchehab+samsung@kernel.org, olof@lxom.net, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, sandipan@linux.vnet.ibm.com, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Wil
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 3:54 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:45:03PM +0200, Bernd Petrovitsch wrote:
> > It's more like
> > ----  snip  ----
> >       case 3:
> >               frob();
> >               __fall_through;
> >               /* no break - fall through */
> >       case 4:
> > ----  snip  ----
> > as "eclipse" doesn't accept anything else.
> >
> > And yes, it's far from "beautiful" but I hadn't time to dig into
> > eclipses innards to fix that.
> >
>
> Doing both is super ugly.  Let's just do comments until Eclipse gets
> updated.

Eclipse as in the IDE?
https://bugs.eclipse.org/bugs/

>
> I had wanted to move to the attribute because that would simplify things
> in Smatch but it's not a huge deal to delay for another year.
>
> regards,
> dan carpenter
>


-- 
Thanks,
~Nick Desaulniers
