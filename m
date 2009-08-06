From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 13:09:03 +0200
Message-ID: <154e089b0908060409v4dff4785x456b5aad2460ed84@mail.gmail.com>
References: <200908061102.14935.kdudka@redhat.com>
	 <200908061130.08387.kdudka@redhat.com>
	 <154e089b0908060239g56261ecp916d7b937014a6fd@mail.gmail.com>
	 <200908061151.11277.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:39738 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZHFLJE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 07:09:04 -0400
Received: by bwz9 with SMTP id 9so677172bwz.41
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 04:09:04 -0700 (PDT)
In-Reply-To: <200908061151.11277.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 6, 2009 at 11:51, Kamil Dudka<kdudka@redhat.com> wrote:
> On Thu August 6 2009 11:39:11 Hannes Eder wrote:
>> >> I guess it is wise to change this in linearize.c as well. =C2=A0M=
ind sending
>> >> a patch?
>> >
>> > The question is if we need/want to :-) It's change of the working =
code
>> > for no real benefit. I am talking only about system-wide headers w=
hich
>> > can be included anywhere.
>>
>> Well I see at least one benefit, a small one though. =C2=A0Syntax
>> highlighting is somewhat confused with "true" and "false", at least
>> emacs is. =C2=A0They appear like the constants, where in fact they a=
re
>> variables.
>
> I can confirm it's the same case with the vim's syntax highlighter.
>
>> The likelyhood to break the code by renaming this two variables is
>> kinda low, no? =C2=A0And IHMO it was not so wise in the first place =
to pick
>> these names. ;)
>
> I would contend that only two variables are affected. They are if we =
consider
> only headers. However the situation is much worse when we concern abo=
ut .c
> files. The patch would be non-trivial. Please try the following comma=
nd:
>
> $ grep --color '[^_]false[^_]' *.c

$ grep --color '\bfalse\b\|\btrue\b' *.c | wc -l
91

some of them are just in comments, does not look to scary to me.  If
others agree that its a good idea to rename them, I can do it if you
don't want to.

-Hannes
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
