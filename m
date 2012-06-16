From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] fix casting constant to _Bool
Date: Sat, 16 Jun 2012 10:20:02 -0700
Message-ID: <CA+55aFxAJ7QSJNn9WeQBNjkRH7_NK=p=esXqZ=05Ndd_dxzYnQ@mail.gmail.com>
References: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
 <CA+55aFwTyqQ5WBL7b8fbCeBhM_sumQXc-SaKSzwOcwk431Vf9g@mail.gmail.com> <20120616165941.GG4400@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55919 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551Ab2FPRUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Jun 2012 13:20:23 -0400
Received: by wgbdr13 with SMTP id dr13so4168363wgb.1
        for <linux-sparse@vger.kernel.org>; Sat, 16 Jun 2012 10:20:22 -0700 (PDT)
In-Reply-To: <20120616165941.GG4400@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Jun 16, 2012 at 9:59 AM, Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
>
> It's pretty rare to see a cast to bool that truncates the value.
> My feeling is that most times they are bugs. =A0I just saw one of
> these a couple weeks ago:
>
> http://www.spinics.net/lists/linux-iio/msg05573.html
>
> I wish the error message could be fixed so it says 1 instead of 0.

Hmm - I could imagine havinbg a warning, but it shouldn't be about trun=
cation.

Maybe something like "Odd constant _Bool cast (%lld -> 1)"? It will
always result in 1, since the only value that results in 0 is 0 (and
isn't odd).

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
