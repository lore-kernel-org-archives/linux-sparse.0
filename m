From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] eliminate insane conversions from int to enum
Date: Mon, 29 Mar 2010 11:11:45 -0700
Message-ID: <70318cbf1003291111t125ecc6cpa3f84987d6e4659b@mail.gmail.com>
References: <1268097872.16227.10.camel@mj>
	 <201003271016.39291.kdudka@redhat.com> <20100327092949.GB9548@feather>
	 <201003271053.47206.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47983 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438Ab0C2SLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 14:11:47 -0400
Received: by vws20 with SMTP id 20so135835vws.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Mar 2010 11:11:45 -0700 (PDT)
In-Reply-To: <201003271053.47206.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Sat, Mar 27, 2010 at 2:53 AM, Kamil Dudka <kdudka@redhat.com> wrote:
> On Saturday 27 of March 2010 10:29:50 Josh Triplett wrote:
>> > Here is what sparse gives:
>> > $ ./sparse enum.c
>> > enum.c:1:10: warning: non-ANSI function declaration of function 'm=
ain'
>> > enum.c:6:15: warning: conversion of
>> > enum.c:6:15: =A0 =A0 int to
>> > enum.c:6:15: =A0 =A0 int enum <noident>
>> >
>> >
>> > Here is what g++ gives:
>> > $ g++ enum.c
>> > enum.c: In function =91int main()=92:
>> > enum.c:6: error: invalid conversion from =91int=92 to =91main()::<=
anonymous
>> > enum>=92
>>
>> Yup, both of these warnings seem correct. =A0Don't fix them by casti=
ng,
>> fix them by declaring "val" with an appropriate integral type.
>
> patch attached

I mention that in my other email. I don't agree this is a better change=
=2E
It is just for the sake of making the enum warning happy and make code
harder to understand.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
