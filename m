From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] memops.c: always true expression
Date: Tue, 23 Nov 2010 02:10:22 -0800
Message-ID: <AANLkTi=3FoqcPvaub=TuF5c5G9B1LpTuabRqWiw8nmhd@mail.gmail.com>
References: <20101121212548.6230da08@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62048 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab0KWKKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Nov 2010 05:10:23 -0500
Received: by iwn38 with SMTP id 38so1155177iwn.19
        for <linux-sparse@vger.kernel.org>; Tue, 23 Nov 2010 02:10:23 -0800 (PST)
In-Reply-To: <20101121212548.6230da08@absol.kitzblitz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolas Kaiser <nikai@nikai.net>
Cc: linux-sparse@vger.kernel.org

On Sun, Nov 21, 2010 at 12:25 PM, Nicolas Kaiser <nikai@nikai.net> wrot=
e:
> I noticed that the second part of this conditional is always true.
> Just a shot in the dark: Could that be a typo?
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (insn->bb && (insn->opcode !=3D OP_L=
OAD || insn->opcode !=3D OP_STORE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (insn->bb && (insn->opcode !=3D OP_L=
OAD && insn->opcode !=3D OP_STORE))

I think you are right. The insn->opcode can't be both OP_LOAD and OP_ST=
ORE.

The fix seems right to me. That is a good catch.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
