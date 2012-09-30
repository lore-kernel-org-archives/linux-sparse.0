From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 8/10] bug.h: Make BUILD_BUG_ON generate compile-time error
Date: Sun, 30 Sep 2012 18:29:01 -0500
Message-ID: <5068D5BD.1000802@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-9-git-send-email-daniel.santos@pobox.com> <20120929003239.GA14293@jtriplet-mobl1> <50664E30.7050809@att.net> <20120929025506.GA3183@leaf>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm13.bullet.mail.sp2.yahoo.com ([98.139.91.83]:35258 "HELO
	nm13.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751201Ab2I3X3A (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Sep 2012 19:29:00 -0400
In-Reply-To: <20120929025506.GA3183@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 09/28/2012 09:55 PM, Josh Triplett wrote:
> Assuming you don't call BUILD_BUG_ON_MSG more than once per line:
>
> /tmp$ cat test.c
> #define BUILD_BUG_ON_MSG_INTERNAL2(cond, msg, line) \
>     do { \
>         extern void __build_bug_on_failed_ ## line (void) __attribute=
__((error(msg))); \
>         if (cond) \
>             __build_bug_on_failed_ ## line(); \
>     } while (0)
>
> #define BUILD_BUG_ON_MSG_INTERNAL(cond, msg, line) BUILD_BUG_ON_MSG_I=
NTERNAL2(cond, msg, line)
> #define BUILD_BUG_ON_MSG(cond, msg) BUILD_BUG_ON_MSG_INTERNAL(cond, m=
sg, __LINE__)
>
> void f(void)
> {
>     BUILD_BUG_ON_MSG(0, "test 1");
>     BUILD_BUG_ON_MSG(1, "test 2");
>     BUILD_BUG_ON_MSG(0, "test 3");
>     BUILD_BUG_ON_MSG(1, "test 4");
> }
> /tmp$ gcc -c test.c
> test.c: In function =E2=80=98f=E2=80=99:
> test.c:14:119: error: call to =E2=80=98__build_bug_on_failed_14=E2=80=
=99 declared with attribute error: test 2
> test.c:16:119: error: call to =E2=80=98__build_bug_on_failed_16=E2=80=
=99 declared with attribute error: test 4
Thanks! This is very nice!  I've done a little more research and
discovered that there's also a __COUNTER__ macro that is available
in gcc 4.3+.  Before I realized that it was only available in gcc
4.3, I wrote this little macro:

#define _CONCAT1(a, b) a##b
#define CONCAT(a, b) _CONCAT1(a, b)

#ifdef __COUNTER__
# define UNIQUIFY(prefix) CONCAT(prefix, __COUNTER__)
#else
# define UNIQUIFY(prefix) CONCAT(prefix, __LINE__)
#endif

However, this could lead to code might compile on gcc 4.3+, but
not compile prior, so this is bad, right?

Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
