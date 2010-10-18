From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Sun, 17 Oct 2010 21:13:15 -0700
Message-ID: <AANLkTimyOUX8a6ZjrcW3jxuFK5+gAEUuVPheHVKzFcVs@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	<AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
	<AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
	<20101016191153.GA19324@feather>
	<AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65129 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0JRENQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Oct 2010 00:13:16 -0400
Received: by iwn35 with SMTP id 35so661959iwn.19
        for <linux-sparse@vger.kernel.org>; Sun, 17 Oct 2010 21:13:15 -0700 (PDT)
In-Reply-To: <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

On Sun, Oct 17, 2010 at 3:31 AM, Tomas Klacko <tomas.klacko@gmail.com> =
wrote:
>> What warning do you encounter about CHECK_TYPE?
> I get:
> main.cc: In function =91int main(int, char**)=92:
> main.cc:19: error: comparison between distinct pointer types =91void*=
=92
> and =91char*=92 lacks a cast
>
> compiler and (important) flags:
> g++ (GCC) 4.2.4 (Ubuntu 4.2.4-1ubuntu4), -Wall -Werror
>
>
> Now, the code2 (file main.cc):
> I get error:
> main.cc: In function =91int main(int, char**)=92:
> main.cc:18: error: invalid conversion from =91void*=92 to =91char*=92

That sounds like some thing need to be fixed before the patch can go in=
=2E

I give this C++ changes more thought. The sparse code is written in
pure C. I don't
want to make C++ as another burden of sparse developers. The
alternative always exist,
which is compiling your sparse related code in C then link to your C++ =
program.
Here is my guide line for the C++ related changes.

The change needs to make sense in C alone. That means no "#ifdef __cplu=
splus".
Sparse itself is pure C.I am not a C++ expert, I really  don't know
what is going on
inside the C++ portion of the code. It is pure burden for most sparse
developers who
don't deal with C++, me included.

Personally I don't care about including sparse header in C++. But that
being said,
I am willing to make some compromise. e.g. the keyword renaming adds no=
 value
for the C code, if that is all it takes to make C++ happy, fine.

The rest still need to make sense in C. E.g. removing the dead label_ar=
g union
is a good change by itself.

=46undamentally the C++ and C99 are not compatible.  So there is a limi=
t
you can push
for including C code in C++. Sparse uses a lot of C specific code in
the header file.
=46or the nasty case, it seems that using the alternative method is not=
 too bad.
It is inconvenient, but only limit to very few users.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
