From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 10:10:30 -0700
Message-ID: <70318cbf0908061010w737ac3d7j1feb1f9744217df7@mail.gmail.com>
References: <200908061102.14935.kdudka@redhat.com>
	 <200908061130.08387.kdudka@redhat.com>
	 <154e089b0908060239g56261ecp916d7b937014a6fd@mail.gmail.com>
	 <200908061151.11277.kdudka@redhat.com>
	 <154e089b0908060409v4dff4785x456b5aad2460ed84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f183.google.com ([209.85.212.183]:57986 "EHLO
	mail-vw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbZHFRKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 13:10:32 -0400
Received: by vws13 with SMTP id 13so936113vws.22
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 10:10:31 -0700 (PDT)
In-Reply-To: <154e089b0908060409v4dff4785x456b5aad2460ed84@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Kamil Dudka <kdudka@redhat.com>, sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 6, 2009 at 4:09 AM, Hannes Eder<hannes@hanneseder.net> wrot=
e:
>> $ grep --color '[^_]false[^_]' *.c
>
> $ grep --color '\bfalse\b\|\btrue\b' *.c | wc -l
> 91
>
> some of them are just in comments, does not look to scary to me. =A0I=
f
> others agree that its a good idea to rename them, I can do it if you
> don't want to.

I would just apply the change to the header file and related variables.
The linearize.h is consider an API header file for other sparse applica=
tion
to use. So we'd better not assume too much on the sparse caller side.

I agree with Kamil that rename variable in linearize.c offer no real
benefits. I consider it more of a personal preference thing. And it is
internal to linearize.c. At this point renaming variable will mess up w=
ith
annotations. It is not good enough reason to do it just to make
the editor happy.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
