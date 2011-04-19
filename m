From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Add new streams to a hash-list based on their names
Date: Tue, 19 Apr 2011 15:13:13 -0700
Message-ID: <BANLkTin4pZPYQh8NBCaW9EjJ89ke_j7Srg@mail.gmail.com>
References: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
 <alpine.LFD.2.02.1104191113010.22048@i5.linux-foundation.org> <BANLkTim28ODvCB541rzmvXVgByF5h-ZAMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43868 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753700Ab1DSWOB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 18:14:01 -0400
Received: from mail-yw0-f46.google.com (mail-yw0-f46.google.com [209.85.213.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3JMDXQ6032033
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 15:13:33 -0700
Received: by ywj3 with SMTP id 3so51817ywj.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 15:13:33 -0700 (PDT)
In-Reply-To: <BANLkTim28ODvCB541rzmvXVgByF5h-ZAMQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Apr 19, 2011 at 3:01 PM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Tue, Apr 19, 2011 at 11:17 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> + =A0 =A0 =A0 while ((c =3D *name++) !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash =3D (hash + (c << 4) + (c >> 4)) =
* 11;
>> +
>> + =A0 =A0 =A0 hash *=3D HASH_PRIME;
>> + =A0 =A0 =A0 hash >>=3D 32 - HASHED_INPUT_BITS;
>
> Just curious about this hash function, obviously it is not the same a=
s the one
> used for hashing idents. Does it have any history or you just code it=
 up?

It resembles the kernel pathname hash function, but without the fancy
"do it in 64 bits on 64-bit architectures".

And the exact shifting etc at the end is different (the kernel sizes
the hash table based on memory size etc).

But it might be a good idea to share the hash function with the idents
- there is absolutely nothing magical about the hashing I picked. The
kernel path component hash function has been "sufficiently good", but
it's nothing magical or special.

                         Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
