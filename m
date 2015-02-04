From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent string litterals
Date: Wed, 04 Feb 2015 09:39:08 +0100
Message-ID: <87r3u6ax5f.fsf@rasmusvillemoes.dk>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:63131 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbbBDIjL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 03:39:11 -0500
Received: by mail-la0-f43.google.com with SMTP id pn19so305196lab.2
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 00:39:10 -0800 (PST)
In-Reply-To: <20150204003208.GA8867@macbook.lan> (Luc Van Oostenryck's message
	of "Wed, 4 Feb 2015 01:32:08 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Wed, Feb 04 2015, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> On Tue, Feb 03, 2015 at 11:38:02PM +0100, Rasmus Villemoes wrote:
>> 
>> Thanks, but there's still something wrong. Using your show-data feature
>> on this:
>> 
>> ===
>> #define BACKSLASH "\\"
>> #define LETTER_t "t"
>> 
>> static const char s1[] = BACKSLASH;
>> /* static const char s2[] = BACKSLASH; */
>> static const char s3[] = BACKSLASH LETTER_t;
>> static const char s4[] = "a" BACKSLASH LETTER_t "b";
>> ===
>> 
>> I get
>> 
>> symbol s1:
>>         char static const [toplevel] s1[0]
>>         bit_size = 16
>>         val = "\\"
>> symbol s3:
>>         char static const [toplevel] s3[0]
>>         bit_size = 24
>>         val = "\0t"
>> symbol s4:
>>         char static const [toplevel] s4[0]
>>         bit_size = 40
>>         val = "a\0tb"
>> 
>> Now if I do the same with s2 not commented out, I get
>> 
>> 
>> symbol s1:
>>         char static const [toplevel] s1[0]
>>         bit_size = 16
>>         val = "\0"
>> symbol s2:
>>         char static const [toplevel] s2[0]
>>         bit_size = 16
>>         val = "\0"
>> symbol s3:
>>         char static const [toplevel] s3[0]
>>         bit_size = 24
>>         val = "\0t"
>> symbol s4:
>>         char static const [toplevel] s4[0]
>>         bit_size = 40
>>         val = "a\0tb"
>> 
>> So the expansion of BACKSLASH changes depending on how often it is
>> expanded...
>> 
>> The LETTER_t thing above is because I thought I had somehow provoked a
>> double expansion, making BACKSLASH LETTER_t (or some variant) expand to
>> a single-character string containing just a tab. But I can't seem to
>> reproduce that particular behaviour, so maybe I'm imagining
>> stuff. Anyway, the above is certainly real.
>> 
>> Thanks,
>> Rasmus
>> --
> Yes, I see.
>
> Now thinking about it, it's obvious that the string buffer can't be reused at all
> if there is any kind of expansion done on it, the adjacent strings concatenation
> make just the thing worse but are not the cause of it.
>

That was also my conclusion from looking at the code, but I was unable
to do anything about it. And I wasn't hallucinating, I was just
overcomplicating things:

#define NOT_TAB "\\t"

static const char s1[] = NOT_TAB;
static const char s2[] = NOT_TAB;

indeed fails.

Thanks,
Rasmus
