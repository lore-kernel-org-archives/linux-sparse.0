From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v4 6/9] compiler.h, bug.h: Prevent double error messages
 with BUILD_BUG{,_ON}
Date: Sat, 03 Nov 2012 13:10:48 -0500
Message-ID: <50955E28.5050609@att.net>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com> <1351457835-7553-6-git-send-email-daniel.santos@pobox.com> <20121030161933.GD28499@liondog.tnic> <5090B875.7030902@att.net> <20121031110609.GD16410@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121031110609.GD16410@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>
Cc: Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

On 10/31/2012 06:06 AM, Borislav Petkov wrote:
>> Realistically, a single macro could be defined in compiler*.h that
>> encapsulates the entirety of this mechanism and only exposes a "black
>> box" macro, that will simply expand to something that breaks the build
>> in the most appropriate fashion based upon the version of gcc.  In
>> essence, the new BUILD_BUG_ON_MSG macro attempts to fill that roll.
>
> Yes.

OK, so I have two solutions, one I like and one that I don't.  Both of
these solutions will use the __compiletime_error_fallback macro, but
cleaned up slightly and it will only be used from within compiler.h (so
it becomes a private macro).

#ifndef __compiletime_error
# define __compiletime_error(message)
# define __compiletime_error_fallback(condition) \
        do { ((void)sizeof(char[1 - 2*!!(condition)])); } while (0)
#else
# define __compiletime_error_fallback(condition) do { } while (0)
#endif

And now let me present the solution that I do not like.

// compiler.h (after the above snippet)

#define __compiletime_error_invoke(condition, func)             \
        do {                                                    \
                bool __cond = !!(condition);                    \
                if (__cond)                                     \
                        func();                                 \
                __compiletime_error_fallback(__cond);           \
        } while (0)
#endif


// bug.h
...
#define __BUILD_BUG_INTERNAL(condition, msg, line)              \
        do {                                                    \
                extern void __build_bug_on_failed_ ## line(void)\
                                __compiletime_error(msg);       \
                __compiletime_error_invoke(condition,           \
                                __build_bug_on_failed_ ## line) \
        } while (0)

#define _BUILD_BUG_INTERNAL(condition, msg, line) \
        __BUILD_BUG_INTERNAL(condition, msg, line)

Rather than using __compiletime_error_fallback externally anywhere, we
just use it in another macro in compiler.h. Then, this
__compiletime_error_invoke macro is actually called to invoke the
error.  This problem is that this is highly disjointed; we end up with
large parts of the implementation in both compiler.h and in bug.h.
(also, I think we would need another macro to expand the concatenation
of __build_bug_on_failed_ ## line, I didn't test the above).

If we are going to move this level of detail out of bug.h, I think we
should move *all* of it.

// compiler.h
...

#define __compiletime_assert(condition, msg, __func)                    \
        do {                                                            \
                bool __cond = !!(condition);                            \
                extern void __func(void) __compiletime_error(msg);      \
                if (__cond)                                             \
                        __func();                                       \
                __compiletime_error_fallback(__cond);                   \
        } while (0)

#define _compiletime_assert(condition, msg, __func) \
        __compiletime_assert(condition, msg, __func)

/**
 * compiletime_assert - some documentation...
 */
#define compiletime_assert(condition, msg) \
        __compiletime_assert(condition, msg, __compiletime_assert_ ##
__LINE__)


// bug.h -- remove *BUILD_BUG_INTERNAL macros entirely and just chance this:

#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(cond, msg)

To me, this is much cleaner. It will give all compile-time assertions
the same base function name, but this shouldn't be much of a problem
since the new error attribute will spit out a nice detailed error
message at the point the error occurs and few people (if any?) should be
having to track this down from the link-time error. Even if you are
having to track it down just from a link-time error, it will tell you
the object file that the function was called from and the line number is
embedded in the function name, so it wouldn't be too hard. For example,
it's possible that the link-time error may be the only thing that breaks
on Intel or some other compilers (clang?). Having the full
implementation in compiler*.h allows for easier tweaking to suit various
compilers as well. (I may need to load up intel's latest compiler and
see how it is there).

Anyway, please let me know if you like it.

Daniel
