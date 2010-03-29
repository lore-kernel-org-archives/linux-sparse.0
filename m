From: Christopher Li <sparse@chrisli.org>
Subject: Re: segfault in sparse snapshot 2010-02-13
Date: Mon, 29 Mar 2010 10:29:10 -0700
Message-ID: <70318cbf1003291029h15b54a56ia1f39781d3986a2d@mail.gmail.com>
References: <20100324104144.0817c22b.rdunlap@xenotime.net>
	 <20100324193622.GC4331@feather> <4BAA6C4C.8010103@xenotime.net>
	 <20100324203427.GA3015@feather> <20100325104947.GC5069@bicker>
	 <20100325154614.GD30147@feather> <4BAB8F36.2090600@xenotime.net>
	 <70318cbf1003251020j11ad7dd9m5e22b52699265526@mail.gmail.com>
	 <70318cbf1003290050x7f15655ra07edba3668eb4a3@mail.gmail.com>
	 <20100329094642.ff0a2e8b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38837 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab0C2R3M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 13:29:12 -0400
Received: by vws20 with SMTP id 20so111852vws.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Mar 2010 10:29:11 -0700 (PDT)
In-Reply-To: <20100329094642.ff0a2e8b.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Josh Triplett <josh@joshtriplett.org>, Dan Carpenter <error27@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Mar 29, 2010 at 9:46 AM, Randy Dunlap <rdunlap@xenotime.net> wr=
ote:
> Hi Chris,
>
> Yes, this gets it past the segfault problem. =A0Thanks.
>
> [Ju:st had a little trouble applying it because it's full of spaces
> instead of tabs. =A0Once I realized that, it was no problem.]

You can just pull from the sparse chrisl branch. Sorry I did not make i=
t clear.

Proper parsing the struct foo __attribute__() { ...} is more challengin=
g than
this simple fix. But I guess a NULL pointer check shouldn't hurt for no=
w.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
