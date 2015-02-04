From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string
 expansion
Date: Thu, 5 Feb 2015 00:38:03 +0100
Message-ID: <20150204233802.GA2275@macpro.local>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
 <20150131012339.GA3460@macpro.local>
 <87386mvcxh.fsf@rasmusvillemoes.dk>
 <20150204020059.GA7069@macpro.local>
 <CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
 <20150204062250.GA9989@macbook.lan>
 <CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51023 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbbBDXiI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 18:38:08 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so35445564wiv.1
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 15:38:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 04, 2015 at 12:01:39AM -0800, Christopher Li wrote:
> On Tue, Feb 3, 2015 at 10:22 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> Are you sure about this behavior? You mean you see "b" has the string
> >> size as 2. I haven't understand how this can happen.
> >
> >
> > But if the macro is used several times:
> > ===
> > #define BACKSLASH "\\"
> > const char a[] = BACKSLASH;
> > const char b[] = BACKSLASH;
> > const char c[] = "<" BACKSLASH ">";
> > ===
> >
> > the, we get:
> > ===
> > symbol a:
> >         char const [addressable] [toplevel] a[0]
> >         bit_size = 16
> >         val = "\0"
> > symbol b:
> >         char const [addressable] [toplevel] b[0]
> >         bit_size = 16
> 
> The value buffer is corrupted. But the bit_size is still 16, which
> is correct. I just think that in your example it shouldn't corrupt
> the size. Your test case seems confirm that.
> 
> > Is it only with macros that the string structure is so shared?
> 
> That is right. I haven't see it can happen any other way.
> The tokenizer always construct new token and string structure
> from the C source file.
> 
> It is the preprocessor using macro expand which copy and duplicate
> the token list. The token has a pointer point to the string which
> is shared across different invocation of macro.

Fine.
I was affraid that there was other possibilities, like, for exemple,
if the identical string litterals are put in an hash table, like it is done
for identifiers.

> > And have we a way to test if the string is coming from a macro?
> 
> Not right now. But we can add it.
> 
> >
> > A simpler and safer way would be to directly do the string expansion just after
> > a string token is recognized, or even better in the lexer itself.
> > So the string buffer, macro or not, will always directly contain the right values.
> > But maybe there was good reasons to not do it this way.
> 
> I have an counter example that will not work. Let say
> 
> #define b(a, d) a##d
> wchar_t s[] = b(L, "\xabcdabc");
> 
> When the lexer process the escape char, you did not know the string
> is wide char or not. That can be changed after the macro expansion.
> 
> Chris

Yes, I see.

BTW, I've checked and there is a lot of problems with wide strings.
I'll send some test case later.


Regards,
Luc
