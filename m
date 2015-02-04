From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string
 expansion
Date: Wed, 4 Feb 2015 07:22:50 +0100
Message-ID: <20150204062250.GA9989@macbook.lan>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
 <20150131012339.GA3460@macpro.local>
 <87386mvcxh.fsf@rasmusvillemoes.dk>
 <20150204020059.GA7069@macpro.local>
 <CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:64798 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbBDGW4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 01:22:56 -0500
Received: by mail-wi0-f182.google.com with SMTP id n3so1287009wiv.3
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 22:22:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 03, 2015 at 09:30:15PM -0800, Christopher Li wrote:
> On Tue, Feb 3, 2015 at 6:01 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > In get_string_constant(), the code tried to reuse the storage for the string
> > but only if the expansion of the string was not bigger than its unexpanded form.
> > But this string can be shared with other expressions and reusing the buffer will
> > result in later corruption
> >
> > A minimal exemple would be something like:
> > const char a[] = BACKSLASH;
> > const char b[] = BACKSLASH;
> >
> > The expansion for 'a' will correctly produce the two-char string consisting
> > of a backslash char followed by a null char.
> > But then the expansion of 'b' will expand this once more,
> > producing the expansion of "\0": the two-char string: { '\0', '\0' }.
> 
> Are you sure about this behavior? You mean you see "b" has the string
> size as 2. I haven't understand how this can happen.

Using the show_data() / sparse -vdata on:
===
#define BACKSLASH "\\"
const char a[] = BACKSLASH;
===

gives, correctly:
===
symbol a:
	char const [addressable] [toplevel] b[0]
	bit_size = 16
	val = "\\"
=== 

But if the macro is used several times:
===
#define BACKSLASH "\\"
const char a[] = BACKSLASH;
const char b[] = BACKSLASH;
const char c[] = "<" BACKSLASH ">";
===

the, we get:
===
symbol a:
	char const [addressable] [toplevel] a[0]
	bit_size = 16
	val = "\0"
symbol b:
	char const [addressable] [toplevel] b[0]
	bit_size = 16
	val = "\0"
symbol c:
	char const [addressable] [toplevel] c[0]
	bit_size = 32
	val = "<\0>"
===

And even worse:
===
#define BACKSLASH "(\\)"
const char m[] = BACKSLASH;
const char n[] = BACKSLASH;
const char k[] = "<" BACKSLASH ">";
===

gives:
===
symbol m:
	char const [addressable] [toplevel] m[0]
	bit_size = 24
	val = "()"
symbol n:
	char const [addressable] [toplevel] n[0]
	bit_size = 24
	val = "()"
symbol k:
	char const [addressable] [toplevel] k[0]
	bit_size = 40
	val = "<()>"
===

> > The fix is to not reuse the storage for the string if any king of expansion
> > have been done.
> 
> That is a bit over kill. We only need to avoid reuse storage if the
> destination part of the string is come from a preprocessor macro.
> It is pretty common string contain escape sequence. We don't
> want to allocate extra memory copy if it is not part of a macro
> expansion.

Well yes ...
Is it only with macros that the string structure is so shared?
And have we a way to test if the string is coming from a macro?

 
> >
> > Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  char.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/char.c b/char.c
> > index 08ca2230..2e21bb77 100644
> > --- a/char.c
> > +++ b/char.c
> > @@ -123,11 +123,15 @@ struct token *get_string_constant(struct token *token, struct expression *expr)
> >                 len = MAX_STRING;
> >         }
> >
> > -       if (len >= string->length)      /* can't cannibalize */
> > +       /* The input string can be shared with other expression and so
> > +        * its storage can't be reused if any kind of expansion have been done on it.
> > +        */
> > +       if ((len != string->length) || memcmp(buffer, string->data, len)) {
> 
> I don' think this check take into account the preprocessor macro has
> been used or not. In other words, any general "hello world\n" which
> contain the escape character will produce a different buffer, there for,
> a new copy of the string. Which is not necessary. That is a pretty
> common case.

No, indeed, it does not.
It just allocate a new buffer every time there is any modification/expansion
so that the original one is not touched (in case it is used elsewhere).

> 
> I am working on patch to address it in the preprocessor macro.
> The idea is that just mark the string as immutable if it is part of the
> macro expansion. I will see how it goes.
> 
> Chris
> --

A simpler and safer way would be to directly do the string expansion just after
a string token is recognized, or even better in the lexer itself.
So the string buffer, macro or not, will always directly contain the right values.
But maybe there was good reasons to not do it this way.

Luc
