From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 10/10] bug.h: Add gcc 4.2+ versions of BUILD_BUG_ON_* macros
Date: Mon, 1 Oct 2012 17:55:26 -0700
Message-ID: <CANN689EoTUakd89D4sAXLFHJ=JzFPaTpisMHFi4Yf_gQ58qngA@mail.gmail.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
	<1348874411-28288-11-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348874411-28288-11-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 28, 2012 at 4:20 PM, Daniel Santos <daniel.santos@pobox.com> wrote:
> BUILD_BUG_ON42(arg)
> BUILD_BUG_ON_CONST42(arg)
>
> Prior to gcc 4.2, the optimizer was unable to determine that many
> constant values stored in structs were indeed compile-time constants and
> optimize them out.  Sometimes, it will find an intergral value to be a
> compile-time constant, but fail to perform a bit-wise AND at
> compile-time.  These two macros provide a mechanism to perform these
> build-time checks, but not break on older compilers where we already
> know they can't be checked at compile time.
>
> For specific details, consult the doc comments for BUILD_BUG_ON_CONST.
> These macros are used in the generic rbtree code.

I think the names are quite confusing. BUILD_BUG_ON_NON_CONST42 sounds
like it's checking if 42 is a constant.

The name probably shouldn't mention what compiler versions support
this check, but instead it should hint as to when you should use this
instead of BUILD_BUG_ON_CONST ? Maybe BUILD_BUG_ON_CONST_DEREF or
something (I'm pretty bad with names too :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
