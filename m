From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/5] Fix some "unknown format" warnings
Date: Sat, 25 May 2013 20:26:47 +0100
Message-ID: <51A11077.2000605@ramsay1.demon.co.uk>
References: <519BC851.5090202@ramsay1.demon.co.uk> <20130521220546.GD11463@jtriplet-mobl1> <519D4031.8010004@ramsay1.demon.co.uk> <20130522225410.GA12285@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:39435 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757816Ab3EYUE4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 May 2013 16:04:56 -0400
In-Reply-To: <20130522225410.GA12285@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> On Wed, May 22, 2013 at 11:01:21PM +0100, Ramsay Jones wrote:
>> Josh Triplett wrote:
>>> On Tue, May 21, 2013 at 08:17:37PM +0100, Ramsay Jones wrote:

>> The current "compat" layer has an string_to_ld() function, so maybe
>> there should be an ld_to_string()? dunno.
> 
> That seems like the best plan, if you can find a portable one to
> include.

Hmm, I'm not sure I understand; in this case, ld_to_string() would just
cast to double in order to sprintf. ;-)

>>>> @@ -463,7 +468,7 @@ const char *show_instruction(struct instruction *insn)
>>>>  	}
>>>>  
>>>>  	if (buf >= buffer + sizeof(buffer))
>>>> -		die("instruction buffer overflowed %td\n", buf - buffer);
>>>> +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
>>>
>>> No, ptrdiff_t does not portably fit in int; it generally has the same
>>> size as size_t (64-bit on 64-bit platforms).  Cast to "long long" and
>>> use PRId64 if you must.
>>
>> Yes, for the same reason, git does:
>>
>>     printf("...%" PRIuMAX "...", (uintmax_t)(buf - buffer));
>>
>> so I'll do that in the re-roll.
> 
> uintmax_t works; I suspect it might be overkill, but it'll work.

Oh, I think int is probably overkill (on 32-bit systems), but this
should cater for all future needs. ;-)

>>>> --- a/pre-process.c
>>>> +++ b/pre-process.c
>>>> @@ -158,12 +158,17 @@ static int expand_one_symbol(struct token **list)
>>>>  	} else if (token->ident == &__DATE___ident) {
>>>>  		if (!t)
>>>>  			time(&t);
>>>> +#if !defined(__MINGW32__)
>>>>  		strftime(buffer, 12, "%b %e %Y", localtime(&t));
>>>> +#else
>>>> +		strftime(buffer, 12, "%b %d %Y", localtime(&t));
>>>> +		if (buffer[4] == '0') buffer[4] = ' ';
>>>> +#endif
>>> To the best of my knowledge, nothing guarantees the length of %b, so the
>>> [4] here seems wrong.
>>
>> Yes, this was just a quick hack to compensate for the lack of the
>> "%e" format specifier in the msvc strftime(). (elsewhere the lack
>> of "%T" was easier to replace). I will have to think about this.
>> Any ideas?
> 
> strftime returns the number of characters it generated; just format the
> "%b " separately so you have the offset needed for the %d and the
> modification.

Yep, I'll look into it. Having said that, I'm not sure we need to make
this string identical on all systems. dunno.

>>>> --- a/tokenize.c
>>>> +++ b/tokenize.c
>>>> @@ -547,8 +547,8 @@ static int get_one_number(int c, int next, stream_t *stream)
>>>>  	}
>>>>  
>>>>  	if (p == buffer_end) {
>>>> -		sparse_error(stream_pos(stream), "number token exceeds %td characters",
>>>> -		      buffer_end - buffer);
>>>> +		sparse_error(stream_pos(stream), "number token exceeds %d characters",
>>>> +		      (int)(buffer_end - buffer));
>>>
>>> Same comment as above regarding ptrdiff_t.
>>>
>>> - Josh Triplett
>>
>> Thanks Josh. You hit every part of the patch that I wanted to
>> tidy up! :-D
> 
> No problem; thanks for working on this!  I'd love to see sparse used for
> Windows compilation.
> 
> Have you managed to use it with a mingw cross-compiler, by any chance?

No, I'm afraid not. :(

ATB,
Ramsay Jones



