From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 11:39:11 +0200
Message-ID: <154e089b0908060239g56261ecp916d7b937014a6fd@mail.gmail.com>
References: <200908061102.14935.kdudka@redhat.com>
	 <154e089b0908060223h6ae15b26q73360ee3658d6a82@mail.gmail.com>
	 <200908061130.08387.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:50592 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZHFJjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 05:39:11 -0400
Received: by bwz9 with SMTP id 9so633945bwz.41
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 02:39:11 -0700 (PDT)
In-Reply-To: <200908061130.08387.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 6, 2009 at 11:30, Kamil Dudka<kdudka@redhat.com> wrote:
> On Thu August 6 2009 11:23:26 Hannes Eder wrote:
>> On Thu, Aug 6, 2009 at 11:02, Kamil Dudka<kdudka@redhat.com> wrote:
>> > It's unfortunate to use 'true' and 'false' as identifiers in a sys=
tem
>> > header. It clashes with corresponding macros from <stdbool.h> when
>> > included before <sparse/linearize.h>.
>> >
>> > Signed-off-by: Kamil Dudka <kdudka@redhat.com>
>> > ---
>> > =C2=A0linearize.h | =C2=A0 =C2=A02 +-
>> > =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/linearize.h b/linearize.h
>> > index 2205082..50b3601 100644
>> > --- a/linearize.h
>> > +++ b/linearize.h
>> > @@ -328,7 +328,7 @@ struct entrypoint {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct instruction *entry;
>> > =C2=A0};
>> >
>> > -extern void insert_select(struct basic_block *bb, struct instruct=
ion
>> > *br, struct instruction *phi, pseudo_t true, pseudo_t false); +ext=
ern
>> > void insert_select(struct basic_block *bb, struct instruction *br,=
 struct
>> > instruction *phi, pseudo_t if_true, pseudo_t if_false);
>>
>> I guess it is wise to change this in linearize.c as well. =C2=A0Mind=
 sending a
>> patch?
>
> The question is if we need/want to :-) It's change of the working cod=
e for no
> real benefit. I am talking only about system-wide headers which can b=
e
> included anywhere.

Well I see at least one benefit, a small one though.  Syntax
highlighting is somewhat confused with "true" and "false", at least
emacs is.  They appear like the constants, where in fact they are
variables.

The likelyhood to break the code by renaming this two variables is
kinda low, no?  And IHMO it was not so wise in the first place to pick
these names. ;)

My 2 cents
-Hannes
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
