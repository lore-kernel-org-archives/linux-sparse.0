From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v4 6/13] bug.h: Replace __linktime_error with __compiletime_error
Date: Mon, 25 Jun 2012 14:30:49 -0500
Message-ID: <4FE8BC69.7000104@att.net>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com> <1340424048-7759-7-git-send-email-daniel.santos@pobox.com> <4FE8AAFC.1080306@windriver.com>
Reply-To: daniel.santos@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4FE8AAFC.1080306@windriver.com>
Sender: linux-doc-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Daniel Santos <daniel.santos@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Rob Landley <rob@landley.net>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-sparse@vger.kernel.org

On 06/25/2012 01:16 PM, Paul Gortmaker wrote:
>
> At a quick glance of the bug.h parts, I would think you need
> this commit _before_ #5 (that deleted __linktime_error) otherwise
> you'll have introduced a bisection build failure.  Or, alternatively
> you could combine #5 and #6 since they are clearly related, and
> their separation is more of a per-file CVS mentality than it is of
> any existence of distinct and separate/unrelated changesets.
>
> P.
Thanks, will do.

And after I thought about this more, I realized that both
__build_bug_failed and __build_bug_on_failed could just be declared
globally rather than being part of the macro. It may not be that big of
a deal, but it would reduce the size of pre-processed files at least
(something I look at a lot working with this patch set). But I'll let
you make the final call on that one

Oh, and as it turns out, adding the string-ized condition in the
BUILD_BUG_ON macro is useless (actually confusing) since gcc takes the
attributes of the first occurrence of an externed function in a
translation unit. Thus, the following code:

#include <linux/bug.h>
void func(void)
{
const int a =3D 0;
BUILD_BUG_ON(a =3D=3D 1);
BUILD_BUG_ON(1) ;
}

would result in the error message:

call to =91__build_bug_on_failed=92 declared with attribute error:
BUILD_BUG_ON failed: a =3D=3D 1

At least the line number is correct however. So my "declare a function
multiple times with with differing attributes" turns out to not work ri=
ght.

