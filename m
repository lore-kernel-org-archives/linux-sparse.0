From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Date: Wed, 3 Oct 2018 00:36:52 +0200
Message-ID: <20181002223652.GA4290@nautica>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au>
 <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>
List-Id: linux-sparse@vger.kernel.org

Miguel Ojeda wrote on Wed, Oct 03, 2018:
> As I have read, -next is supposed to be a vision of what the merge
> window will look like after merging everything, i.e. ideally -rc1. For
> that to work for files out-of-tree (like these ones, which are not
> maintained by a single tree), changes should be allowed to be stacked
> on each other; otherwise, we cannot handle conflicts :-(

The rule is the same as with a regular mainline pull; I don't have the
reference at hand but in some recent-ish pull request Linus said he
prefers the stable version with the conflict, and optionally you can
provide a second branch with the conflict resolved for reference, but
the pull request should be based on something stable even if it has
conflicts

If there is a conflict Stefen will resolve it like Linus/Greg would, and
the resolved bit will be carried over everyday so it's not much more
work -- exactly like a regular pull request for inclusion in the main
tree :)


(Found another mail arguing for stable base[1], but can't find the mail I
was thinking of)
 [1] http://lkml.kernel.org/r/CA+55aFw+dwofadgvzrM-UCMSih+f1choCwW+xFFM3aPjoRQX_g@mail.gmail.com

-- 
Dominique Martinet
