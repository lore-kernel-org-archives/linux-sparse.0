From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Date: Wed, 3 Oct 2018 09:00:47 -0400
Message-ID: <20181003090047.5aa88fc4@gandalf.local.home>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
        <20181003071059.02b3fd6f@canb.auug.org.au>
        <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
        <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
        <20181002223652.GA4290@nautica>
        <20181003090010.5150f914@canb.auug.org.au>
        <CANiq72nLLhTf3AsXqLkPmK6TV_g7E3tML9XaM_zE45dM7XPn-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72nLLhTf3AsXqLkPmK6TV_g7E3tML9XaM_zE45dM7XPn-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>
List-Id: linux-sparse@vger.kernel.org

On Wed, 3 Oct 2018 14:34:28 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> When I sent the first email, I assumed that changes in -next were
> supposed to be clean -- my mistake, but please document somewhere how
> -next works! Specially that you are rerere'ing conflicts and
> re-resolving them every day.

Yes, a document in the Documentation directory on how to work with
linux-next may be a good idea. Something we can point people to when
they start using linux-next. I know there was something in the initial
email, but I've lost that.

-- Steve
