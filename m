From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Tue, 28 Aug 2018 12:55:42 +0200
Message-ID: <CAK8P3a2NgqV6fnQSaTFKWdBpwp656L9Kp4NB=bwTwRb8ojZAuQ@mail.gmail.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.santos@pobox.com
Cc: Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Aug 27, 2018 at 10:44 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> >> Now we're back to the question of "what do you mean by 'constant'"?  If
> >> you mean a C constant expression (as defined in the C standard) than
> >> almost none of this code fits that criteria.  For these compile-time
> >> assertions to work, we are concerned with the data flow analysis and
> >> constant propagation performed by the compiler during optimization.  You
> >> will notice in include/linux/compiler.h that __compiletime_assert is a
> >> no-op when __OPTIMIZE__ is not defined.
> > Depending on optimizations for static assertions sounds problematic.
>
> (with my best Palpatine voice) It is unavoidable.
>
> Actually it's theoretically possible, but the compiler would have to do
> something akin to copying it's control flow graph et. al, run -O2-ish
> optimizations, perform the static assertions and then throw away the
> optimized control flow graph and emit code based upon the original.

In the context of the kernel, compiling with anything less than -O2 or
-Os is not an issue, we don't do it anyway. -O0 never worked, and
AFAICT we only build one file with -O1, but that is something we can do
away with as well:

from fs/reiserfs/Makefile:
# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
# functions are used.  This causes the compiler to advance the stack
# pointer out of the available stack space, corrupting kernel space,
# and causing a panic. Since this behavior only affects ppc32, this ifeq
# will work around it. If any other architecture displays this behavior,
# add it here.
ccflags-$(CONFIG_PPC32) := $(call cc-ifversion, -lt, 0400, -O1)

     Arnd
