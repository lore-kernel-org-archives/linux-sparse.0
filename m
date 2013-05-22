From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/5] Fix some "unknown format" warnings
Date: Wed, 22 May 2013 23:01:21 +0100
Message-ID: <519D4031.8010004@ramsay1.demon.co.uk>
References: <519BC851.5090202@ramsay1.demon.co.uk> <20130521220546.GD11463@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:55751 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757527Ab3EVWOQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 18:14:16 -0400
In-Reply-To: <20130521220546.GD11463@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> On Tue, May 21, 2013 at 08:17:37PM +0100, Ramsay Jones wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
> 
> %Ld for a long long int is actually broken on all architectures; L only
> works for long double.  Thanks for fixing that.

Yep, I had forgotten about that change. I should have sent that four
years ago. Sorry about that.

> Formatting nit: I think this reads better when written as:
> 
> "... blah blah " PRIx64 " blah blah ..."
> 
> , leaving spaces between the macro and the close/open doublequotes.

OK, will do.

> 
> Further comments below.
> 
>> @@ -336,10 +337,14 @@ const char *show_instruction(struct instruction *insn)
>>  			
>>  		switch (expr->type) {
>>  		case EXPR_VALUE:
>> -			buf += sprintf(buf, "%lld", expr->value);
>> +			buf += sprintf(buf, "%"PRId64, expr->value);
>>  			break;
>>  		case EXPR_FVALUE:
>> +#if !defined(__MINGW32__)
>>  			buf += sprintf(buf, "%Lf", expr->fvalue);
>> +#else
>> +			buf += sprintf(buf, "%f", (double)expr->fvalue);
>> +#endif
> 
> This seems really sad; does MinGW really have long double but no way to
> print it?  Can we at least emit something here to indicate possible
> truncation or loss of precision, if no means exists to print a long
> double?

I couldn't find any means to do so, just from experimentation (I didn't
have any MinGW specific gcc documentation). Thus, I tried:

  $ cat -n junk.c
       1  #include <stdio.h>
       2
       3  int main(int argc, char *argv[])
       4  {
       5          long double f = 128.821L;
       6
       7          printf("sizeof(float) = %d\n", sizeof(float));
       8          printf("sizeof(double) = %d\n", sizeof(double));
       9          printf("sizeof(long double) = %d\n", sizeof(long double));
      10          printf("f = %Lf\n", f);
      11          return 0;
      12  }

  $ gcc -Wall -o junk junk.c
  junk.c: In function 'main':
  junk.c:10: warning: unknown conversion type character 'L' in format
  junk.c:10: warning: too many arguments for format
  $ ./junk.exe
  sizeof(float) = 4
  sizeof(double) = 8
  sizeof(long double) = 12
  f = -0.000000

  $ cl -W4 junk.c
  Microsoft (R) 32-bit C/C++ Optimizing Compiler Version 15.00.30729.01 for 80x86
  Copyright (C) Microsoft Corporation.  All rights reserved.

  junk.c
  junk.c(3) : warning C4100: 'argv' : unreferenced formal parameter
  junk.c(3) : warning C4100: 'argc' : unreferenced formal parameter
  Microsoft (R) Incremental Linker Version 9.00.30729.01
  Copyright (C) Microsoft Corporation.  All rights reserved.

  /out:junk.exe
  junk.obj
  $ ./junk.exe
  sizeof(float) = 4
  sizeof(double) = 8
  sizeof(long double) = 8
  f = 128.821000
  $

So, msvc knows about the L size modifier, but it treats a 'long double'
the same as a 'double'.

  $ vim junk.c # change format specifier %Lf => %lf
  $ gcc -Wall -o junk junk.c
  junk.c: In function 'main':
  junk.c:10: warning: format '%lf' expects type 'double', but argument 2 has type
  'long double'
  $ ./junk.exe
  sizeof(float) = 4
  sizeof(double) = 8
  sizeof(long double) = 12
  f = -0.000000
  $

I'm sure you can guess what happens if you try "%f" instead.

The current "compat" layer has an string_to_ld() function, so maybe
there should be an ld_to_string()? dunno.

[A 64-bit MinGW system probably doesn't have this problem, of course ...]

> 
>> @@ -463,7 +468,7 @@ const char *show_instruction(struct instruction *insn)
>>  	}
>>  
>>  	if (buf >= buffer + sizeof(buffer))
>> -		die("instruction buffer overflowed %td\n", buf - buffer);
>> +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
> 
> No, ptrdiff_t does not portably fit in int; it generally has the same
> size as size_t (64-bit on 64-bit platforms).  Cast to "long long" and
> use PRId64 if you must.

Yes, for the same reason, git does:

    printf("...%" PRIuMAX "...", (uintmax_t)(buf - buffer));

so I'll do that in the re-roll.

> 
>> --- a/pre-process.c
>> +++ b/pre-process.c
>> @@ -158,12 +158,17 @@ static int expand_one_symbol(struct token **list)
>>  	} else if (token->ident == &__DATE___ident) {
>>  		if (!t)
>>  			time(&t);
>> +#if !defined(__MINGW32__)
>>  		strftime(buffer, 12, "%b %e %Y", localtime(&t));
>> +#else
>> +		strftime(buffer, 12, "%b %d %Y", localtime(&t));
>> +		if (buffer[4] == '0') buffer[4] = ' ';
>> +#endif
> To the best of my knowledge, nothing guarantees the length of %b, so the
> [4] here seems wrong.

Yes, this was just a quick hack to compensate for the lack of the
"%e" format specifier in the msvc strftime(). (elsewhere the lack
of "%T" was easier to replace). I will have to think about this.
Any ideas?

>> @@ -980,7 +981,11 @@ static int show_fvalue(struct expression *expr)
>>  	int new = new_pseudo();
>>  	long double value = expr->fvalue;
>>  
>> +#if !defined(__MINGW32__)
>>  	printf("\tmovf.%d\t\tv%d,$%Lf\n", expr->ctype->bit_size, new, value);
>> +#else
>> +	printf("\tmovf.%d\t\tv%d,$%f\n", expr->ctype->bit_size, new, (double)value);
>> +#endif
> 
> Same comment as above regarding long double.
> 
>> --- a/tokenize.c
>> +++ b/tokenize.c
>> @@ -547,8 +547,8 @@ static int get_one_number(int c, int next, stream_t *stream)
>>  	}
>>  
>>  	if (p == buffer_end) {
>> -		sparse_error(stream_pos(stream), "number token exceeds %td characters",
>> -		      buffer_end - buffer);
>> +		sparse_error(stream_pos(stream), "number token exceeds %d characters",
>> +		      (int)(buffer_end - buffer));
> 
> Same comment as above regarding ptrdiff_t.
> 
> - Josh Triplett

Thanks Josh. You hit every part of the patch that I wanted to
tidy up! :-D

ATB,
Ramsay Jones



