From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v2 09/10] bug.h: Add BUILD_BUG_ON_MSG & BUILD_BUG_INTERNAL{,2}
Date: Fri, 05 Oct 2012 23:41:01 -0500
Message-ID: <506FB65D.70109@att.net>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com> <1349466169-20637-9-git-send-email-daniel.santos@pobox.com> <20121005205858.GB28452@liondog.tnic> <20121005210258.GB7362@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm12-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.242]:31327 "HELO
	nm12-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750762Ab2JFElF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 00:41:05 -0400
In-Reply-To: <20121005210258.GB7362@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>

On 10/05/2012 04:02 PM, Josh Triplett wrote:
> On Fri, Oct 05, 2012 at 10:58:58PM +0200, Borislav Petkov wrote:
>> On Fri, Oct 05, 2012 at 02:42:48PM -0500, danielfsantos@att.net wrot=
e:
>>> Add BUILD_BUG_ON_MSG which behaves like BUILD_BUG_ON (with optimiza=
tions
>>> turned enabled), except that it allows you to specify the error mes=
sage
>>> you want emitted as the third parameter.  Under the hood, this reli=
es on
>>> BUILD_BUG_INTERNAL{,2}, which does the actual work and is pretty-mu=
ch
>>> identical to BUILD_BUG_ON.
>>>
>>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>>> ---
>>>  include/linux/bug.h |   26 ++++++++++++++++++++++++++
>>>  1 files changed, 26 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/linux/bug.h b/include/linux/bug.h
>>> index 1b43ea2..91bd9d5 100644
>>> --- a/include/linux/bug.h
>>> +++ b/include/linux/bug.h
>>> @@ -16,6 +16,7 @@ struct pt_regs;
>>>  #define BUILD_BUG_ON_NOT_POWER_OF_2(n)
>>>  #define BUILD_BUG_ON_ZERO(e) (0)
>>>  #define BUILD_BUG_ON_NULL(e) ((void*)0)
>>> +#define BUILD_BUG_ON_MSG(cond, msg) (0)
>>>  #define BUILD_BUG_ON(condition) (0)
>>>  #define BUILD_BUG() (0)
>>>  #else /* __CHECKER__ */
>>> @@ -38,6 +39,31 @@ struct pt_regs;
>>>   */
>>>  #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e)))=
)
>>> =20
>>> +#define _CONCAT1(a, b) a##b
>>> +#define CONCAT(a, b) _CONCAT1(a, b)
>>
>> Let's call the indirection _CONCAT without the "1".

No problem, naming conventions are good! :)

>>
>>> +#define UNIQUIFY(prefix) CONCAT(prefix, __LINE__)
>>> +
>>> +#define BUILD_BUG_INTERNAL2(condition, msg, fn)			\
>>> +	do {							\
>>> +		extern void fn (void) __compiletime_error(msg);	\
>>> +		__compiletime_error_fallback(condition);	\
>>> +		if (condition)					\
>>> +			fn();					\
>>> +	} while (0)
>>> +
>>> +#define BUILD_BUG_INTERNAL(condition, msg, fn) \
>>> +	BUILD_BUG_INTERNAL2(condition, msg, fn)
>>
>> Ditto. BUILD_BUG_INTERNAL2 should be __BUILD_BUG_INTERNAL and the on=
e
>> calling it _BUILD_BUG_INTERNAL (with one underscore).
>
> Also, you don't need both the BUILD_BUG_INTERNAL and CONCAT/UNIQUIFY
> macros.  My original implementation just used the BUILD_BUG_INTERNAL
> family of macros; if you'd rather rename them, by all means do so, bu=
t I
> don't think you need two separate families of multiply-indirect macro=
s.

Yeah, I was thinking in terms of reusable macros.  I'm kinda thinking t=
he
kernel needs a header just for handy little macros, like concat,
uniquify, the
IS_EMPTY and IF_EMPTY macros of mine in rbtree.h, etc.  There is a
stringify.h
that just contains a __stringify macro.  But here, it's just verbose, s=
o
I'll
change it back to how you had it.

>>> +
>>> +/**
>>> + * BUILD_BUG_ON_MSG - break compile if a condition is true & emit =
supplied
>>> + * 		      error message.
>>> + * @condition: the condition which the compiler should know is fal=
se.
>>> + *
>>> + * See BUILD_BUG_ON for description.
>>> + */
>>> +#define BUILD_BUG_ON_MSG(cond, msg) \
>>> +	BUILD_BUG_INTERNAL(cond, msg, UNIQUIFY(__build_bug_on_failed_))
>>
>> Btw, why are we adding the line at all? It is issued by gcc anyway:
>>
>> cc -Wall    macros.c   -o macros
>> macros.c: In function =E2=80=98main=E2=80=99:
>> macros.c:22:1: error: =E2=80=98__build_bug_on_failed_22=E2=80=99 und=
eclared (first use in this function)
>
> Because without that, you end up writing multiple prototypes for the
> same function (__build_bug_on_failed) with different error attributes=
,
> and GCC will ignore all but the last error attribute it sees, even wi=
th
> a scoped prototype.

Yeah, this is part of the trick to get non-existent functions with diff=
erent
messages on their error attributes, so that each BUILD_BUG_ON-type macr=
o can
have more helpful text in its error message.  I don't know what's in yo=
ur
macros.c, but it should have given you a much more shiny error message.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
