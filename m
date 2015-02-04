From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string expansion
Date: Wed, 4 Feb 2015 00:01:39 -0800
Message-ID: <CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204020059.GA7069@macpro.local>
	<CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
	<20150204062250.GA9989@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:50695 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbbBDIBk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 03:01:40 -0500
Received: by mail-qc0-f172.google.com with SMTP id x3so109143qcv.3
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 00:01:39 -0800 (PST)
In-Reply-To: <20150204062250.GA9989@macbook.lan>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 3, 2015 at 10:22 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Are you sure about this behavior? You mean you see "b" has the string
>> size as 2. I haven't understand how this can happen.
>
>
> But if the macro is used several times:
> ===
> #define BACKSLASH "\\"
> const char a[] = BACKSLASH;
> const char b[] = BACKSLASH;
> const char c[] = "<" BACKSLASH ">";
> ===
>
> the, we get:
> ===
> symbol a:
>         char const [addressable] [toplevel] a[0]
>         bit_size = 16
>         val = "\0"
> symbol b:
>         char const [addressable] [toplevel] b[0]
>         bit_size = 16

The value buffer is corrupted. But the bit_size is still 16, which
is correct. I just think that in your example it shouldn't corrupt
the size. Your test case seems confirm that.

> Is it only with macros that the string structure is so shared?

That is right. I haven't see it can happen any other way.
The tokenizer always construct new token and string structure
from the C source file.

It is the preprocessor using macro expand which copy and duplicate
the token list. The token has a pointer point to the string which
is shared across different invocation of macro.

> And have we a way to test if the string is coming from a macro?

Not right now. But we can add it.

>
> A simpler and safer way would be to directly do the string expansion just after
> a string token is recognized, or even better in the lexer itself.
> So the string buffer, macro or not, will always directly contain the right values.
> But maybe there was good reasons to not do it this way.

I have an counter example that will not work. Let say

#define b(a, d) a##d
wchar_t s[] = b(L, "\xabcdabc");

When the lexer process the escape char, you did not know the string
is wide char or not. That can be changed after the macro expansion.

Chris
