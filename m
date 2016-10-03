From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] sparse: add 'alloc_align' to the ignored attributes
Date: Mon, 3 Oct 2016 14:42:26 +0100
Message-ID: <dc32908a-92db-7085-5e51-46e6d5fc1f4c@ramsayjones.plus.com>
References: <574EF186.5030505@ramsayjones.plus.com>
 <CANeU7QmX8+Ja62vp9DPQwqPGQqkmp0o38v+A1w6Rq6CaY-BPVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:39628 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcJCNuN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 3 Oct 2016 09:50:13 -0400
In-Reply-To: <CANeU7QmX8+Ja62vp9DPQwqPGQqkmp0o38v+A1w6Rq6CaY-BPVQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 28/09/16 23:10, Christopher Li wrote:
> On Wed, Jun 1, 2016 at 7:30 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Rui's recent patch prompted me to send this patch, which I have been
>> running with for a while.
> 
> Sorry for the late reply. The patch looks good.
> 
> Can you add some test case for the alloc_align()? I want to see how
> your source code use the attribute. Just in case we need to parse
> the attribute properly.

Sorry for the late reply! ;-)

I can't send you an example of _my_ use of the alloc_align attribute,
since I don't use it in my code. This attribute was being used in the
<stdlib.h> standard library header file (New Lib) on cygwin, which
results in errors like:

    $ CHECK=../sparse/sparse make git.sp
        SP git.c
    /usr/include/stdlib.h:304:53: error: attribute '__alloc_align__': unknown attribute
    $ 

for each C file in the git build.

This is not the only problem I've had with New-Lib recently; they have
been having problems exposing/not-exposing functions based on feature
request macros (like POSIX_SOURCE, GNU_SOURCE, BSD_SOURCE, etc). To be
fair, they have fixed quite a few such problems lately. (but it is _much_
easier for me to add a patch to sparse to fix this up!)

On this occasion, it seems that New-Lib thinks the C11 standard has been
requested (I haven't checked if gcc on cygwin _doesn't_ default to gnu11):

    $ tail -14 /usr/include/stdlib.h
    /*
     * If we're in a mode greater than C99, expose C11 functions.
     */
    #if __ISO_C_VISIBLE >= 2011
    void *	aligned_alloc(size_t, size_t) __malloc_like __alloc_align(1)
    	    __alloc_size(2);
    int	at_quick_exit(void (*)(void));
    _Noreturn void
    	quick_exit(int);
    #endif /* __ISO_C_VISIBLE >= 2011 */

    _END_STD_C

    #endif /* _STDLIB_H_ */
    $ 

Note that the macro __alloc_align is defined in /usr/include/sys/cdefs.h
like so:

    #if __GNUC_PREREQ__(4, 9) || __has_attribute(__alloc_align__)
    #define __alloc_align(x)        __attribute__((__alloc_align__(x)))
    #else
    #define __alloc_align(x)
    #endif

If you look at the <stdlib.h> header on Linux, you will find very
similar code, so if I were to request C11, I would have the same
issue on Linux.

Another, only slightly related, issue: recent versions of gcc have
greatly increased the number of pre-defined macros, designed to make
it easier for c-libraries to implement <stdint.h>, <limits.h>, etc,
(among other things), which New-Lib is now using. Unfortunately, they
have not used sensible fall-backs if these macros are not defined ... :(

In order not to have a veritable blizzard of sparse errors, I have to
place this into my 'config.mak' file on cygwin:

    SPARSE_FLAGS += -D__INTPTR_TYPE__='long int'
    SPARSE_FLAGS += -D__INT32_TYPE__=int
    SPARSE_FLAGS += -D__INT32_MAX__=2147483647
    SPARSE_FLAGS += -D__UINT32_TYPE__='unsigned int'
    SPARSE_FLAGS += -D__UINT32_MAX__=4294967295U
    SPARSE_FLAGS += -D__INT64_TYPE__='long int'
    SPARSE_FLAGS += -D__INT64_MAX__=9223372036854775807L
    SPARSE_FLAGS += -D__UINT64_TYPE__='long unsigned int'
    SPARSE_FLAGS += -D__UINT64_MAX__=18446744073709551615UL
    SPARSE_FLAGS += -D__INTMAX_TYPE__='long int'
    SPARSE_FLAGS += -D__INTMAX_MAX__=9223372036854775807L
    SPARSE_FLAGS += -D__UINTMAX_TYPE__='long unsigned int'
    SPARSE_FLAGS += -D__UINTMAX_MAX__=18446744073709551615UL
    SPARSE_FLAGS += -D__SIZE_TYPE__='long unsigned int'
    SPARSE_FLAGS += -D__SIZE_MAX__=18446744073709551615UL

[That is not the complete list of macros, of course, just the minimum
to suppress the errors on the git build.]

This is not a problem on Linux, since glibc headers do not depend
on these macros being defined (at the moment, anyway).


ATB,
Ramsay Jones




