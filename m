From: Christopher Li <sparse@chrisli.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 4 May 2012 02:25:47 -0700
Message-ID: <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
	<CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
	<4FA38635.5060300@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37518 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753245Ab2EDJZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 05:25:47 -0400
Received: by ghrr11 with SMTP id r11so2582736ghr.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 02:25:47 -0700 (PDT)
In-Reply-To: <4FA38635.5060300@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, linux-sparse@vger.kernel.org

On Fri, May 4, 2012 at 12:33 AM, Konrad Eisele <konrad@gaisler.com> wro=
te:
>> I agree this is useful. However I feel the original patch is a bit
>> invasive.
>> How about do it in a step by step way. Make a small patch to allow
>> register
>> call backs when the macro expands. That way the application using sp=
arse
>> get notify of the pre-processor macro expands. I can take a look at =
how to
>> implement this small patch as well.
>>
>> If needed, we can make one option that pre-processor don't free the
>> tokens.
>> In this case, very few changes in the caller side. I feel it cleaner
>> than changing
>> the free function behavior.
>
>
> The minimum original-code-base change that I see would be:
> =A0- "struct position <pos>" is removed in all structures except "str=
uct
> token" and
> =A0 replaced with "struct token *<tok>". When <pos> is needed <tok>->=
pos is
> =A0 used instead. This implies that tokens are not freed by default.

No, that would be a no go. I don't mind allow dependence program
have the option to keep the token around. However, for other C back
ends, the token serve no purpose. It just sit there waste memory. So
I don't want the token become mandatory.

> =A0- struct statement *, struct expression *, struct *token
> =A0 all get a extra "void *custom" pointer. This pointer can be used =
for
> =A0 tools to save their own data.
> I think this is not too far off: 4 bytes more for each struct and
> =A0"<tok>->pos"
> instead of "pos", that is not a massive change. the <tok>->pos would =
be
> a boilerplate refactoring.

It is still too invasive. I don't want to keep <tok>->pos in the statem=
ents
and expression.

Instead, how about using the macro_expand I purposed in previous
email. Make dependence program a two step. The first step is pure
pre-processing, the dependants program using the macro_expand hook
to keep track of macro expand details. The end result is the pre-proces=
sed
file and the program remember how the file map into original file using=
 the
macro expand history.

The the second step is just parsing on the pre-processed file. Using
the macro expand history to map the position back to the original file.
In this way, you can do your dependency analyse with minimal
impact to sparse internals. The macro_expand hook can use to
do other useful stuff as well. Will that address your need?

BTW, have you take a look at the ctags program come with sparse?
It can find symbols created by macro expansion as well.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
