From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] remove validation/tmp.o in clean target
Date: Tue, 4 Aug 2015 02:44:34 -0400
Message-ID: <CANeU7Q=x4aF3CqrP-prJmtLj_jVz+yji5b8Sn-V7FOtnfHCM4g@mail.gmail.com>
References: <1437299869-3669-1-git-send-email-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33467 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbbHDGof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Aug 2015 02:44:35 -0400
Received: by ykoo205 with SMTP id o205so518604yko.0
        for <linux-sparse@vger.kernel.org>; Mon, 03 Aug 2015 23:44:34 -0700 (PDT)
In-Reply-To: <1437299869-3669-1-git-send-email-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 19, 2015 at 5:57 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koen=
ig.org> wrote:
> To prevent validation/tmp.o being still around after
>
>         make check && make clean
>
> remove it as part of the latter command.

Looks good. I would like to apply it.

Can you send me a "signed-off-by" line please?
While you are at it, you can combine the two patches into one.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
