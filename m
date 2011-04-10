From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH] unify usage of VOID
Date: Mon, 11 Apr 2011 01:34:43 +0200
Message-ID: <4DA23E93.8010105@seznam.cz>
References: <4DA1D9A1.3090109@seznam.cz> <BANLkTi=VYG-YwbSXksBgUayZfwTOWtfYiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep27.mx.upcmail.net ([62.179.121.47]:59104 "EHLO
	fep27.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1DJXeu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Apr 2011 19:34:50 -0400
In-Reply-To: <BANLkTi=VYG-YwbSXksBgUayZfwTOWtfYiQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On 04/11/2011 12:20 AM, Christopher Li wrote:
> Hi Jan,
>=20
> You are one fire with this sparse code :-)
>=20
> I will take a closer look of your patch series tonight.
>=20
> Thanks
>=20
> Chris
>=20
>=20
> On Sun, Apr 10, 2011 at 9:24 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz=
> wrote:
>> Also remove unneeded empty initializator of `void_pseudo'.
>>
>> Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
>> ---
>>  linearize.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linearize.c b/linearize.c
>> index f2034ce..46c9726 100644
>> --- a/linearize.c
>> +++ b/linearize.c
>> @@ -33,7 +33,7 @@ struct access_data;
>>  static pseudo_t add_load(struct entrypoint *ep, struct access_data =
*);
>>  static pseudo_t linearize_initializer(struct entrypoint *ep, struct=
 expression *initializer, struct access_data *);
>>
>> -struct pseudo void_pseudo =3D {};
>> +struct pseudo void_pseudo;
>>
>>  static struct position current_pos;
>>
>> @@ -1880,7 +1880,7 @@ pseudo_t linearize_statement(struct entrypoint=
 *ep, struct statement *stmt)
>>                struct basic_block *active;
>>                pseudo_t src =3D linearize_expression(ep, expr);
>>                active =3D ep->active;
>> -               if (active && src !=3D &void_pseudo) {
>> +               if (active && src !=3D VOID) {
>>                        struct instruction *phi_node =3D first_instru=
ction(bb_return->insns);
>>                        pseudo_t phi;
>>                        if (!phi_node) {
>> --
>> 1.7.1
>> --

Hi Chris,

thank you for considering these patches, feel free to bother me with
complains :-)

I think I will have some more patches to send, but it should not be
tightly related to what I have already posted (if so, I'll make it expl=
icit).

--=20
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
