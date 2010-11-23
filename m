From: Anderson Lizardo <anderson.lizardo@gmail.com>
Subject: Re: [PATCH] memops.c: always true expression
Date: Tue, 23 Nov 2010 10:50:33 -0400
Message-ID: <AANLkTikvAHyp6oDWStQQmCGD7zA2qFumeHbV-FQ_BqrW@mail.gmail.com>
References: <20101121212548.6230da08@absol.kitzblitz>
	<AANLkTi=3FoqcPvaub=TuF5c5G9B1LpTuabRqWiw8nmhd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52885 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab0KWOue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Nov 2010 09:50:34 -0500
Received: by vws13 with SMTP id 13so4192262vws.19
        for <linux-sparse@vger.kernel.org>; Tue, 23 Nov 2010 06:50:34 -0800 (PST)
In-Reply-To: <AANLkTi=3FoqcPvaub=TuF5c5G9B1LpTuabRqWiw8nmhd@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolas Kaiser <nikai@nikai.net>, linux-sparse@vger.kernel.org

On Tue, Nov 23, 2010 at 6:10 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Sun, Nov 21, 2010 at 12:25 PM, Nicolas Kaiser <nikai@nikai.net> wr=
ote:
>> I noticed that the second part of this conditional is always true.
>> Just a shot in the dark: Could that be a typo?
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (insn->bb && (insn->opcode !=3D OP_=
LOAD || insn->opcode !=3D OP_STORE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (insn->bb && (insn->opcode !=3D OP_=
LOAD && insn->opcode !=3D OP_STORE))
>
> I think you are right. The insn->opcode can't be both OP_LOAD and OP_=
STORE.
>
> The fix seems right to me. That is a good catch.

I wonder if running sparse on it could catch this...

Regards,
--=20
Anderson Lizardo
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
