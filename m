From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] better dealing with OP_PHISOURCE insn
Date: Thu, 14 Apr 2011 03:10:15 -0700
Message-ID: <BANLkTimoNvYiGCaBo7N4+j=B_WJ4dUNrug@mail.gmail.com>
References: <4DA048C2.8060501@seznam.cz>
	<4DA04BE8.9060706@seznam.cz>
	<4DA04D3B.1010309@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33417 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758683Ab1DNKKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 14 Apr 2011 06:10:16 -0400
Received: by vws1 with SMTP id 1so1152329vws.19
        for <linux-sparse@vger.kernel.org>; Thu, 14 Apr 2011 03:10:15 -0700 (PDT)
In-Reply-To: <4DA04D3B.1010309@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: linux-sparse@vger.kernel.org

On Sat, Apr 9, 2011 at 5:12 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz> w=
rote:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def->opcode =3D=3D OP_PHI) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phi_defines(def, target=
, defines);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 defines(def->bb, phi->def, target);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if this ever fails (very unlikely), =
it's a sign of a regression */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 assert(def->opcode =3D=3D OP_PHISOURCE)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 defines(def->bb, def, target);
> =A0 =A0 =A0 =A0} END_FOR_EACH_PTR(phi);

That comment usually means there is some thing fishy going on there.
I think you are on to some thing. The original code mean to recursively
define all the phi source, if the phi source is come from another phi n=
ode.
But the original code seems wrong. It should lookat def->phi_src->def->=
opcode
instead of def->opcode. I don't think we should remove the phi_defines =
there.
I need to double check this as well.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
