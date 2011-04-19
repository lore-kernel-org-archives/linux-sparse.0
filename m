From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] Add new streams to a hash-list based on their names
Date: Tue, 19 Apr 2011 15:01:48 -0700
Message-ID: <BANLkTim28ODvCB541rzmvXVgByF5h-ZAMQ@mail.gmail.com>
References: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
	<alpine.LFD.2.02.1104191113010.22048@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab1DSWBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 18:01:48 -0400
Received: by vws1 with SMTP id 1so119682vws.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 15:01:48 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1104191113010.22048@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Apr 19, 2011 at 11:17 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> + =A0 =A0 =A0 while ((c =3D *name++) !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash =3D (hash + (c << 4) + (c >> 4)) *=
 11;
> +
> + =A0 =A0 =A0 hash *=3D HASH_PRIME;
> + =A0 =A0 =A0 hash >>=3D 32 - HASHED_INPUT_BITS;

Just curious about this hash function, obviously it is not the same as =
the one
used for hashing idents. Does it have any history or you just code it u=
p?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
