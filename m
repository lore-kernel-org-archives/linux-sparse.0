From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] evaluate: Allow sizeof(_Bool) to succeed.
Date: Mon, 9 May 2011 13:31:10 -0700
Message-ID: <BANLkTim26gM+WxF+XSjZTVf+sL9xLLtCoA@mail.gmail.com>
References: <1304552394-16280-1-git-send-email-blp@nicira.com>
	<BANLkTikHwADf5Kv5=rQosKcNjsMYM-28wQ@mail.gmail.com>
	<20110509200231.GG2971@nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63579 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1EIUbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 May 2011 16:31:12 -0400
Received: by wwa36 with SMTP id 36so6155536wwa.1
        for <linux-sparse@vger.kernel.org>; Mon, 09 May 2011 13:31:10 -0700 (PDT)
In-Reply-To: <20110509200231.GG2971@nicira.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ben Pfaff <blp@nicira.com>
Cc: linux-sparse@vger.kernel.org

On Mon, May 9, 2011 at 1:02 PM, Ben Pfaff <blp@nicira.com> wrote:

> Thank you for applying my patch. =A0It does work for me, in the sense
> that I get a warning instead of an error now, but I'm not so happy to
> get any diagnostic at all. =A0Is there some reason why sizeof(_Bool)
> warrants a warning when, say, sizeof(long) does not? =A0After all, bo=
th
> sizes are implementation defined.

Because sizeof(_Bool) is a little bit special compare to sizeof(long).
In the case of long, all sizeof(long) * 8 bits are use in the actual va=
lue.
But for the _Bool, only the 1 bit is used in the 8 bits size. In other =
words,
the _Bool has a special case of the actual bit size is not a multiple o=
f 8.

Sparse has two hats, it is a C compiler front end, and more often it is
used in the Linux kernel source sanitize checking. Depending on the siz=
eof
_Bool sounds a little bit suspicious in the kernel. I would love to the=
 heard
your actual usage case of the sizeof(_Bool). Why do you care about this
warning?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
