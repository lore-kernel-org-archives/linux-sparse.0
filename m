From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 4/5] sparse, i386: Fix boolean bit size
Date: Fri, 26 Aug 2011 08:28:05 +0300
Message-ID: <CAOJsxLG6OFC6tBYQtHu7k_3bYKWeag0cGiogG4XYQM6tCUeTgQ@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
	<1314021451-24808-4-git-send-email-penberg@kernel.org>
	<CANeU7QktGkA-u9x7FzDUosVjNfhYeNv0C9o0G9n=SmuivWeNpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47525 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1HZF2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Aug 2011 01:28:06 -0400
Received: by ywf7 with SMTP id 7so2454535ywf.19
        for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 22:28:05 -0700 (PDT)
In-Reply-To: <CANeU7QktGkA-u9x7FzDUosVjNfhYeNv0C9o0G9n=SmuivWeNpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 26, 2011 at 6:59 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Mon, Aug 22, 2011 at 6:57 AM, Pekka Enberg <penberg@kernel.org> wr=
ote:
>> The value of 'ctype->bit_size' is set to 1 for booleans which confus=
es the i386
>> backend:
>>
>> =A0./compile allocate.c
>> =A0compile: compile-i386.c:1406: emit_binop: Assertion `0' failed.
>> =A0Aborted
>>
>> Looking at the code, we assume that "bit_size / 8" gives a sane resu=
lt on
>> various places. This patch fixes the problem by bumping bit_size to =
8 for
>> booleans. This also makes sizeof(_Bool) return 1 which is consistent=
 with what
>> GCC 4.4.3, for example, does.
>>
>> diff --git a/target.c b/target.c
>> index 17b228a..6a535bc 100644
>> --- a/target.c
>> +++ b/target.c
>> @@ -14,7 +14,7 @@ int max_alignment =3D 16;
>> =A0/*
>> =A0* Integer data types
>> =A0*/
>> -int bits_in_bool =3D 1;
>> +int bits_in_bool =3D 8;
>
> I object this part. I consider the sizeof(_Bool) =3D=3D 1 as external=
 behaviour.
> But internally we should know that the real useful part of bool is in=
 just one
> bit, not any bit of that =A01 byte storage.

You missed the most important part of my reasoning: sparse code
already expects "bit_size / 8" to return a non-zero number and it's
not just compile-i386.c! So while I don't disagree with you that we
should internally know that a bool is just one bit, I don't consider
that to be relevant for this particular patch.

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
