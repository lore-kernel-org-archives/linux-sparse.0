From: Tomas Klacko <tomas.klacko@gmail.com>
Subject: Re: including sparse headers in C++ code
Date: Wed, 20 Oct 2010 00:49:33 +0200
Message-ID: <AANLkTi=QryvTC=Q3xsNh4fyhT3V-WZ1VSaE4=JPntz=n@mail.gmail.com>
References: <20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	<AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
	<AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
	<20101016191153.GA19324@feather>
	<AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
	<20101018053955.GA1628@feather>
	<AANLkTim2ti8+aht_f=Mv=0iLZCvF65CFF6GNP2gHF=Kq@mail.gmail.com>
	<AANLkTinuRiaMZExudng5ECeunmF4s2ptnfaE=fYBft=i@mail.gmail.com>
	<20101019213109.GV19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57542 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab0JSWte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Oct 2010 18:49:34 -0400
Received: by gyg13 with SMTP id 13so214584gyg.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Oct 2010 15:49:33 -0700 (PDT)
In-Reply-To: <20101019213109.GV19804@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Tue, Oct 19, 2010 at 11:31 PM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
> On Tue, Oct 19, 2010 at 10:03:42PM +0200, Tomas Klacko wrote:

>> =A0static inline int match_op(struct token *token, int op)
>> =A0{
>> - =A0 =A0 return token->pos.type =3D=3D TOKEN_SPECIAL && token->spec=
ial =3D=3D op;
>> + =A0 =A0 return token->pos.type =3D=3D TOKEN_SPECIAL && token->spec=
ial =3D=3D (unsigned int)op;
>
> What was that one for?

"warning: comparison between signed and unsigned integer expressions"

Tomas Klacko
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
