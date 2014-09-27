From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 01/10] Add the __restrict__ keyword
Date: Sat, 27 Sep 2014 13:42:32 +0100
Message-ID: <5426B0B8.4000709@ramsay1.demon.co.uk>
References: <53E3DD56.1030706@ramsay1.demon.co.uk> <CANeU7QkWoXrrjdZvDFCM4yzFH7h70=1WraB7m3ggVrCan11dwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:58752 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783AbaI0MtA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 08:49:00 -0400
In-Reply-To: <CANeU7QkWoXrrjdZvDFCM4yzFH7h70=1WraB7m3ggVrCan11dwQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 27/09/14 01:47, Christopher Li wrote:
> Catching up my backlog.
> 
> On Fri, Aug 8, 2014 at 4:11 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
[...]

>> Just for the
>> record, I don't know of any use of __restrict__ in an abstract array
>> declaration on _any_ platform.
> 
> If there is no code using the __restrict__ for abstract array, we shouldn't need
> this line:

Of course, just because I'm not aware of any such use, doesn't mean
there isn't one. :-D

gcc supports this usage, so it would be useful if sparse did also.

>> @@ -1553,7 +1554,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
>>
>>         token = abstract_array_static_declarator(token, &has_static);
>>
>> -       if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
>> +       if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
>>                 token = abstract_array_static_declarator(token->next, &has_static);
>>         token = parse_expression(token, &expr);
>>         sym->array_size = expr;
> 
> Or, if you have valid reason to add it. Please provide a test case for
> this code path.

Yep, will do.

ATB,
Ramsay Jones



