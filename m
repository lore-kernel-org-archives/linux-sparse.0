From: Christopher Li <sparse@chrisli.org>
Subject: Re: segfault in sparse snapshot 2010-02-13
Date: Mon, 29 Mar 2010 00:50:31 -0700
Message-ID: <70318cbf1003290050x7f15655ra07edba3668eb4a3@mail.gmail.com>
References: <20100324104144.0817c22b.rdunlap@xenotime.net>
	 <20100324193622.GC4331@feather> <4BAA6C4C.8010103@xenotime.net>
	 <20100324203427.GA3015@feather> <20100325104947.GC5069@bicker>
	 <20100325154614.GD30147@feather> <4BAB8F36.2090600@xenotime.net>
	 <70318cbf1003251020j11ad7dd9m5e22b52699265526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44128 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab0C2Hue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 03:50:34 -0400
Received: by vws8 with SMTP id 8so2375917vws.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Mar 2010 00:50:33 -0700 (PDT)
In-Reply-To: <70318cbf1003251020j11ad7dd9m5e22b52699265526@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Josh Triplett <josh@joshtriplett.org>, Dan Carpenter <error27@gmail.com>, linux-sparse@vger.kernel.org

On Thu, Mar 25, 2010 at 10:20 AM, Christopher Li <sparse@chrisli.org> w=
rote:
> On Thu, Mar 25, 2010 at 9:28 AM, Randy Dunlap <rdunlap@xenotime.net> =
wrote:
>>
>> OK, I emailed that file, but it's huge -- it probably won't be on th=
e
>> mailing list, so I also uploaded it to here:
>> =A0http://www.xenotime.net/linux/doc/br_fdb.i
>
> Thanks, I can duplicate the segfault now.
>
> Looking at it.

Hi,

I check in a change at.

commit 703499e552b45542a328e3016868419d65143f2b
Author: Christopher <sparse@chrisli.org>
Date:   Sun Mar 28 22:41:49 2010 -0700

    evaluate: check for NULL type inside typeof

    This should fix the segfault report by Randy.
    It still doesn't parse the struct attribute correctly though.

    Signed-off-by: Christopher <sparse@chrisli.org>

diff --git a/evaluate.c b/evaluate.c
index 28bfd7c..cdbd064 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -340,7 +340,9 @@ static inline int classify_type(struct symbol
*type, struct sy
                type =3D type->ctype.base_type;
        if (type->type =3D=3D SYM_TYPEOF) {
                type =3D evaluate_expression(type->initializer);
-               if (type->type =3D=3D SYM_NODE)
+               if (!type)
+                       type =3D &bad_ctype;
+               else if (type->type =3D=3D SYM_NODE)
                        type =3D type->ctype.base_type;
        }
        if (type->type =3D=3D SYM_ENUM)


That should stop the segfault. Please verify. More work needs to be don=
e
to parse the struct attribute correctly.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
