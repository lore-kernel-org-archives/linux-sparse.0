From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 22:10:42 +0300
Message-ID: <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
	<56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45795 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab2FHTKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 15:10:43 -0400
Received: by yenm10 with SMTP id m10so1524334yen.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 12:10:42 -0700 (PDT)
In-Reply-To: <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Fri, Jun 8, 2012 at 6:45 PM, Xi Wang <xi.wang@gmail.com> wrote:
> On Jun 8, 2012, at 6:47 AM, Xi Wang wrote:
>> - =A0 =A0 =A0 =A0 =A0 =A0 oldvalue =3D cast_pseudo(ep, oldvalue, src=
->ctype, expr->ctype);
>> - =A0 =A0 =A0 =A0 =A0 =A0 opcode =3D opcode_sign(op_trans[expr->op -=
 SPECIAL_BASE], src->ctype);
>> - =A0 =A0 =A0 =A0 =A0 =A0 dst =3D add_binary_op(ep, src->ctype, opco=
de, oldvalue, value);
>> - =A0 =A0 =A0 =A0 =A0 =A0 value =3D cast_pseudo(ep, dst, expr->ctype=
, src->ctype);
>> + =A0 =A0 =A0 =A0 =A0 =A0 opcode =3D opcode_sign(op_trans[expr->op -=
 SPECIAL_BASE], expr->ctype);
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D cast_pseudo(ep, value, src->ctyp=
e, expr->ctype);
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D add_binary_op(ep, expr->ctype, o=
pcode, oldvalue, value);
>
> For sparse-llvm, is it better to get rid of the cast_pseudo()
> at all?
>
> For example, what to emit for p +=3D 1:
>
> 1) pointer p + integer 1,
>
> 2) pointer + pointer [cast from integer], or
>
> 3) (pointer)(integer [cast from pointer] + integer)?

Dunno.

This:

void *foo(void *p)
{
  p +=3D 1;

  return p;
}

is converted as follows by clang:

define i8* @foo(i8* %p) nounwind uwtable readnone {
  %1 =3D getelementptr i8* %p, i64 1
  ret i8* %1
}

[ You can try it out yourself here: http://llvm.org/demo/index.cgi ]

So it seems that LLVM really wants to use the "getelementptr" thingy
for these. I have no idea what makes the most sense from sparse IR
point of view.

Jeff, Linus, Chris, hmm?

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
