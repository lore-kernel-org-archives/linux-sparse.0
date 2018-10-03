From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Date: Wed, 3 Oct 2018 14:34:28 +0200
Message-ID: <CANiq72nLLhTf3AsXqLkPmK6TV_g7E3tML9XaM_zE45dM7XPn-A@mail.gmail.com>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au> <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
 <20181002223652.GA4290@nautica> <20181003090010.5150f914@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003090010.5150f914@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>
List-Id: linux-sparse@vger.kernel.org

Hi Stephen,

On Wed, Oct 3, 2018 at 1:00 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Miguel,
>
> On Wed, 3 Oct 2018 00:36:52 +0200 Dominique Martinet <asmadeus@codewreck.org> wrote:
> >
> > Miguel Ojeda wrote on Wed, Oct 03, 2018:
> > > As I have read, -next is supposed to be a vision of what the merge
> > > window will look like after merging everything, i.e. ideally -rc1. For
> > > that to work for files out-of-tree (like these ones, which are not
> > > maintained by a single tree), changes should be allowed to be stacked
> > > on each other; otherwise, we cannot handle conflicts :-(
> >
> > The rule is the same as with a regular mainline pull; I don't have the
> > reference at hand but in some recent-ish pull request Linus said he
> > prefers the stable version with the conflict, and optionally you can
> > provide a second branch with the conflict resolved for reference, but
> > the pull request should be based on something stable even if it has
> > conflicts
> >
> > If there is a conflict Stefen will resolve it like Linus/Greg would, and
> > the resolved bit will be carried over everyday so it's not much more
> > work -- exactly like a regular pull request for inclusion in the main
> > tree :)
>
> Exactly what Dominique said.  I will fix up the conflict (unless it is
> a very complex conflict, in which case the author(s) should help) and
> the Linus (or Greg) will do the same.  If you do depend on a patch in
> Andrew's series, what happens if that patch does not get sent to Linus
> during the merge window or Linus rejects it?

This doesn't depend on anything. Not sure what is all the fuss about
-- people got confused into thinking we had to drop a patch for some
reason. As explained in the first email, I simply rebased v5 (which is
based on top of rcX) to resolve the conflict myself (i.e. it does
*not* depend on changes in -next). If you are the one solving
conflicts yourself (which is what I asked in my second email), there
is no problem to begin with; I will simply send v6 to you and we are
done.

When I sent the first email, I assumed that changes in -next were
supposed to be clean -- my mistake, but please document somewhere how
-next works! Specially that you are rerere'ing conflicts and
re-resolving them every day.

Then the discussion shifted to what to do with changes that actually
depend on other changes.

Cheers,
Miguel
