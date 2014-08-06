From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 01/10] Add the __restrict__ keyword
Date: Wed, 06 Aug 2014 16:21:45 +0100
Message-ID: <53E24809.5020603@ramsay1.demon.co.uk>
References: <53DFD1D2.5050600@ramsay1.demon.co.uk> <CANeU7Qkr5oX-_iLRXTt6DKD4pCwV3LoWPy9CuhQ0kk9NLz7s_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:35853 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752854AbaHFPVt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Aug 2014 11:21:49 -0400
In-Reply-To: <CANeU7Qkr5oX-_iLRXTt6DKD4pCwV3LoWPy9CuhQ0kk9NLz7s_Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 06/08/14 10:19, Christopher Li wrote:
> On Mon, Aug 4, 2014 at 11:32 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> -       if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
>> +       if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
>>                 token = abstract_array_static_declarator(token->next, &has_static);
>>         token = parse_expression(token, &expr);
>>         sym->array_size = expr;
>> diff --git a/validation/reserved.c b/validation/reserved.c
>> index caacd21..e5d7af8 100644
>> --- a/validation/reserved.c
>> +++ b/validation/reserved.c
>> @@ -30,6 +30,7 @@ reserved.c:8:12: error: Trying to use reserved word '__const' as identifier
>>  reserved.c:9:12: error: Trying to use reserved word '__const__' as identifier
>>  reserved.c:10:12: error: Trying to use reserved word 'restrict' as identifier
>>  reserved.c:11:12: error: Trying to use reserved word '__restrict' as identifier
>> +reserved.c:12:12: error: Trying to use reserved word '__restrict__' as identifier
>>  reserved.c:13:12: error: Trying to use reserved word 'typedef' as identifier
>>  reserved.c:14:12: error: Trying to use reserved word '__typeof' as identifier
>>  reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier
> 
> Can you give more test case for __restrict__? Your patch seems suggest that you
> hit some  code use "__restruct__" for abstract array declaration. Did
> that actually
> happen? I want to get some example.

No, __restrict__ is only applied to various pointer types in the MinGW
header files (see below). So, I agree that validation/reserved.c is not
exactly representative of the actual use of __restrict__ (or *any* of the
keywords come to that), but that does at least provide a minimal test.
Also, I can't believe that Al did not intend to include __restrict__ in the
original commit d5c9c2431; well actually he *did* include it in the test, he
just didn't notice some of the missing implementation! ;-D

Having said that, I think I see two tests included for the array declaration
usage: abstract-array-declarator-static.c and restrict-array.c.

As for the MinGW headers, I can only talk about the current/old 32-bit
version of MinGW (I read somewhere that the new MinGW-64 project will
actually re-vamp the 32-bit version as well), but my installation was
updated only last September, so they are still being used. One of the
reasons for the MinGW patches being on the back-burner is because I
haven't installed the 64-bit version yet (last time I looked, it wasn't
considered ready for use).

I have included, below, the output of a grep for __restrict__ in the
header files, which returned 50 matching lines (note that the one and
only use of __restrict in the declaration of strtoll which must have
been a typo!).

HTH,

ATB,
Ramsay Jones

-- 8< --
/mingw/include/inttypes.h:264:intmax_t __cdecl __MINGW_NOTHROW strtoimax (const char* __restrict__ nptr,
/mingw/include/inttypes.h:265:                            char** __restrict__ endptr, int base);
/mingw/include/inttypes.h:266:uintmax_t __cdecl __MINGW_NOTHROW strtoumax (const char* __restrict__ nptr,
/mingw/include/inttypes.h:267:			     char** __restrict__ endptr, int base);
/mingw/include/inttypes.h:269:intmax_t __cdecl __MINGW_NOTHROW wcstoimax (const wchar_t* __restrict__ nptr,
/mingw/include/inttypes.h:270:                            wchar_t** __restrict__ endptr, int base);
/mingw/include/inttypes.h:271:uintmax_t __cdecl __MINGW_NOTHROW wcstoumax (const wchar_t* __restrict__ nptr,
/mingw/include/inttypes.h:272:			     wchar_t** __restrict__ endptr, int base);
/mingw/include/search.h:82:void * __cdecl tdelete (const void * __restrict__, void ** __restrict__,
/mingw/include/stdio.h:333:int __cdecl __MINGW_NOTHROW vscanf (const char * __restrict__, __VALIST);
/mingw/include/stdio.h:334:int __cdecl __MINGW_NOTHROW vfscanf (FILE * __restrict__, const char * __restrict__,
/mingw/include/stdio.h:336:int __cdecl __MINGW_NOTHROW vsscanf (const char * __restrict__,
/mingw/include/stdio.h:337:		     const char * __restrict__, __VALIST);
/mingw/include/stdio.h:607:int __cdecl __MINGW_NOTHROW vwscanf (const wchar_t * __restrict__, __VALIST);
/mingw/include/stdio.h:608:int __cdecl __MINGW_NOTHROW vfwscanf (FILE * __restrict__,
/mingw/include/stdio.h:609:		       const wchar_t * __restrict__, __VALIST);
/mingw/include/stdio.h:610:int __cdecl __MINGW_NOTHROW vswscanf (const wchar_t * __restrict__,
/mingw/include/stdio.h:611:		       const wchar_t * __restrict__, __VALIST);
/mingw/include/stdlib.h:318:strtod (const char* __restrict__ __nptr, char** __restrict__ __endptr)
/mingw/include/stdlib.h:322:float __cdecl __MINGW_NOTHROW strtof (const char * __restrict__, char ** __restrict__);
/mingw/include/stdlib.h:323:long double __cdecl __MINGW_NOTHROW strtold (const char * __restrict__, char ** __restrict__);
/mingw/include/stdlib.h:337:float __cdecl __MINGW_NOTHROW wcstof( const wchar_t * __restrict__, wchar_t ** __restrict__);
/mingw/include/stdlib.h:338:long double __cdecl __MINGW_NOTHROW wcstold (const wchar_t * __restrict__, wchar_t ** __restrict__);
/mingw/include/stdlib.h:518:long long  __cdecl __MINGW_NOTHROW strtoll (const char* __restrict__, char** __restrict, int);
/mingw/include/stdlib.h:519:unsigned long long  __cdecl __MINGW_NOTHROW strtoull (const char* __restrict__, char** __restrict__, int);
/mingw/include/sys/time.h:39:int __cdecl __MINGW_NOTHROW gettimeofday(struct timeval *__restrict__,
/mingw/include/sys/time.h:40:			 void *__restrict__  /*	tzp (unused) */);
/mingw/include/wchar.h:150:int __cdecl __MINGW_NOTHROW vwscanf (const wchar_t * __restrict__, __VALIST);
/mingw/include/wchar.h:151:int __cdecl __MINGW_NOTHROW vfwscanf (FILE * __restrict__,
/mingw/include/wchar.h:152:		       const wchar_t * __restrict__, __VALIST);
/mingw/include/wchar.h:153:int __cdecl __MINGW_NOTHROW vswscanf (const wchar_t * __restrict__,
/mingw/include/wchar.h:154:		       const wchar_t * __restrict__, __VALIST);
/mingw/include/wchar.h:165:float __cdecl __MINGW_NOTHROW wcstof (const wchar_t * __restrict__, wchar_t ** __restrict__);
/mingw/include/wchar.h:166:long double __cdecl __MINGW_NOTHROW wcstold (const wchar_t * __restrict__, wchar_t ** __restrict__);
/mingw/include/wchar.h:281:size_t __cdecl __MINGW_NOTHROW mbrlen(const char * __restrict__, size_t,
/mingw/include/wchar.h:282:		      mbstate_t * __restrict__);
/mingw/include/wchar.h:283:size_t __cdecl __MINGW_NOTHROW mbrtowc(wchar_t * __restrict__, const char * __restrict__,
/mingw/include/wchar.h:284:		       size_t, mbstate_t * __restrict__);
/mingw/include/wchar.h:285:size_t __cdecl __MINGW_NOTHROW mbsrtowcs(wchar_t * __restrict__, const char ** __restrict__,
/mingw/include/wchar.h:286:			 size_t, mbstate_t * __restrict__);
/mingw/include/wchar.h:287:size_t __cdecl __MINGW_NOTHROW wcrtomb(char * __restrict__, wchar_t,
/mingw/include/wchar.h:288:		       mbstate_t * __restrict__);
/mingw/include/wchar.h:289:size_t __cdecl __MINGW_NOTHROW wcsrtombs(char * __restrict__, const wchar_t ** __restrict__,
/mingw/include/wchar.h:290:			 size_t, mbstate_t * __restrict__);
/mingw/include/wchar.h:306:wchar_t* __cdecl __MINGW_NOTHROW wmemcpy(wchar_t* __restrict__,
/mingw/include/wchar.h:307:		         const wchar_t* __restrict__,
/mingw/include/wchar.h:310:long long __cdecl __MINGW_NOTHROW wcstoll(const wchar_t * __restrict__,
/mingw/include/wchar.h:311:			  wchar_t** __restrict__, int);
/mingw/include/wchar.h:312:unsigned long long __cdecl __MINGW_NOTHROW wcstoull(const wchar_t * __restrict__,
/mingw/include/wchar.h:313:			    wchar_t ** __restrict__, int);


