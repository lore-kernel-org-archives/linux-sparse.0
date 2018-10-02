From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Date: Wed, 3 Oct 2018 00:04:29 +0200
Message-ID: <CANiq72nh0nybEC8SizQ9rv=RvncMuTH-dt5vciRtvQ1aFBzJcg@mail.gmail.com>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003071059.02b3fd6f@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-sparse@vger.kernel.org

Hi Stephen,

On Tue, Oct 2, 2018 at 11:11 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Miguel,
>
> On Tue, 2 Oct 2018 15:47:12 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > The Compiler Attributes series has been stable for 10+ days. To
> > increase testing before 4.20, I would to request it being picked up
> > for -next.
> >
> > The changes w.r.t. v5 in the LKML:
> >
> >   - Rebased on top of next-20180928, which required removing
>
> Unfortunately, trees/branches included in linux-next must be based on
> something stable (usually Linus' tree, but it could be another
> tree/branch that is included in linux-next that does not rebase).
> Linux-next itself rebases every day, so snything based on it would drag
> in a previous version of all the other trees :-(

I assumed you could apply changes as a diff/patches/cherry-pick, not
as a merge, for those that went on top of others (so that at the new
merge window, conflicts were already solved). Otherwise, why are
next-* tags/branches provided anyway?

>
> > aligned_largest, which was removed by 9503cd9cbaba
> > ("include/linux/compiler*.h: add version detection to
> > asm_volatile_goto").
>
> That commit is from Andrew's patch series which also rebases (usually
> at least every week), so you cannot depend on it.

Then who is solving the conflict?

Thanks!

Cheers,
Miguel
