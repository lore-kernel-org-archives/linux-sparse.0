From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string expansion
Date: Tue, 3 Feb 2015 21:30:15 -0800
Message-ID: <CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204020059.GA7069@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:60681 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbBDFaQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 00:30:16 -0500
Received: by mail-qg0-f41.google.com with SMTP id q108so55911376qgd.0
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 21:30:15 -0800 (PST)
In-Reply-To: <20150204020059.GA7069@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 3, 2015 at 6:01 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> In get_string_constant(), the code tried to reuse the storage for the string
> but only if the expansion of the string was not bigger than its unexpanded form.
> But this string can be shared with other expressions and reusing the buffer will
> result in later corruption
>
> A minimal exemple would be something like:
> const char a[] = BACKSLASH;
> const char b[] = BACKSLASH;
>
> The expansion for 'a' will correctly produce the two-char string consisting
> of a backslash char followed by a null char.
> But then the expansion of 'b' will expand this once more,
> producing the expansion of "\0": the two-char string: { '\0', '\0' }.

Are you sure about this behavior? You mean you see "b" has the string
size as 2. I haven't understand how this can happen.

> The fix is to not reuse the storage for the string if any king of expansion
> have been done.

That is a bit over kill. We only need to avoid reuse storage if the
destination part of the string is come from a preprocessor macro.
It is pretty common string contain escape sequence. We don't
want to allocate extra memory copy if it is not part of a macro
expansion.

>
> Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  char.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/char.c b/char.c
> index 08ca2230..2e21bb77 100644
> --- a/char.c
> +++ b/char.c
> @@ -123,11 +123,15 @@ struct token *get_string_constant(struct token *token, struct expression *expr)
>                 len = MAX_STRING;
>         }
>
> -       if (len >= string->length)      /* can't cannibalize */
> +       /* The input string can be shared with other expression and so
> +        * its storage can't be reused if any kind of expansion have been done on it.
> +        */
> +       if ((len != string->length) || memcmp(buffer, string->data, len)) {

I don' think this check take into account the preprocessor macro has
been used or not. In other words, any general "hello world\n" which
contain the escape character will produce a different buffer, there for,
a new copy of the string. Which is not necessary. That is a pretty
common case.

I am working on patch to address it in the preprocessor macro.
The idea is that just mark the string as immutable if it is part of the
macro expansion. I will see how it goes.

Chris
