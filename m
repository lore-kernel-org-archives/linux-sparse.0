From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 24 Mar 2010 03:07:04 -0700
Message-ID: <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
References: <1268097872.16227.10.camel@mj>
	 <70318cbf1003101356u48688264na5c9d71bc1ef4300@mail.gmail.com>
	 <201003131822.49308.kdudka@redhat.com>
	 <201003211627.14164.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56551 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab0CXKHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Mar 2010 06:07:05 -0400
Received: by vws8 with SMTP id 8so208856vws.19
        for <linux-sparse@vger.kernel.org>; Wed, 24 Mar 2010 03:07:04 -0700 (PDT)
In-Reply-To: <201003211627.14164.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Pavel Roskin <proski@gnu.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Sun, Mar 21, 2010 at 8:27 AM, Kamil Dudka <kdudka@redhat.com> wrote:
> On Saturday 13 of March 2010 18:22:48 Kamil Dudka wrote:
>> I was unsuscessfully looking for an implementation of stack within s=
parse.
>> So that I used the implicit one instead. =A0I know it's pretty bad i=
dea, but
>> I am not aware of any easy way to handle it better.
>
> I could probably use a list instead. =A0Nevertheless the evaluation o=
f EXPR_COND
> also works recursively on the runtime stack - see evaluate_expression=
() and
> evaluate_conditional_expression(). =A0So that I don't think it's an a=
ctual
> problem here.
>
> Let me know if the patch needs some additional improvements.


Hi Kamil,

I take a look at the new patch. BTW, you don't need to do assert(0),
you can use die() for that.

Currently if I run sparse over the parse.c, it will generate a lot of
new warnings.

$ ./sparse -D__x86_64__=3D1 parse.c
parse.c:1564:67: warning: conversion of
parse.c:1564:67:     int to
parse.c:1564:67:     int enum namespace
expression.h:202:76: warning: conversion of
expression.h:202:76:     int to
expression.h:202:76:     int enum namespace
expression.h:202:76: warning: conversion of
expression.h:202:76:     int to
expression.h:202:76:     int enum namespace
parse.c:182:30: warning: conversion of
parse.c:182:30:     int to
parse.c:182:30:     int enum keyword
parse.c:208:30: warning: conversion of
parse.c:208:30:     int to
parse.c:208:30:     int enum keyword
parse.c:215:30: warning: conversion of
parse.c:215:30:     int to
parse.c:215:30:     int enum keyword
parse.c:235:30: warning: conversion of
parse.c:235:30:     int to
parse.c:235:30:     int enum keyword
parse.c:482:12: warning: symbol 'ignored_attributes' was not declared.
Should it be static?
parse.c:619:22: warning: conversion of
parse.c:619:22:     int to
parse.c:619:22:     int enum statement_type
parse.c:1426:61: warning: conversion of
parse.c:1426:61:     int to
parse.c:1426:61:     int enum namespace
expression.h:202:76: warning: conversion of
expression.h:202:76:     int to
expression.h:202:76:     int enum namespace
parse.c:1533:67: warning: conversion of
parse.c:1533:67:     int to
parse.c:1533:67:     int enum namespace
expression.h:202:76: warning: conversion of
expression.h:202:76:     int to
expression.h:202:76:     int enum namespace
expression.h:202:76: warning: conversion of
expression.h:202:76:     int to
expression.h:202:76:     int enum namespace
expression.h:202:76: warning: conversion of
expression.h:202:76:     int to
expression.h:202:76:     int enum namespace


That is just too much. Most of the warning is coming from enum or opera=
tion.
e.g.
=2Etype =3D KW_SPECIFIER | KW_SHORT,
lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);

I think those source are fine. Force enum cast there make the source co=
de
lworse. We can add special case for enum OR enum, more special cases.
But where is the end?

It comes down to we try to treat enum as a different type than int. It =
seems
works for the simple case. But in real world, people do use enum as int=
 type
and expect enum can mix with int.

At this point I am leaning towards moving this enum warning to a topic =
branch.
Let the people who want to use it play with it first. It currently
give too many warning.
If people do feel that warning is useful, even bette, it catch some rea=
l bugs. I
will consider merge it again.

You obvious spend a lot of time on this. I feel bad about pushing it ba=
ck too.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
