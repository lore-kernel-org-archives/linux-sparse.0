From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Fri, 18 Jun 2010 02:40:42 -0700
Message-ID: <AANLkTil84_v2xi2HR_HjTTLMDAOZmyXbSmPrJ-KiQIzl@mail.gmail.com>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz>
	<AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>
	<4C1250D3.10003@suse.cz>
	<AANLkTikFcgP9fOlzepBbrX4GM0ESJaMiHlT1v2bMUVBw@mail.gmail.com>
	<AANLkTimGxxcjL74Yxshk3ybzQld3uf3Yhuk6VNAvQZWA@mail.gmail.com>
	<4C1B2C95.8000903@suse.cz>
	<4C1B2E77.3090404@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53106 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144Ab0FRJkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Jun 2010 05:40:43 -0400
Received: by gye5 with SMTP id 5so615135gye.19
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jun 2010 02:40:43 -0700 (PDT)
In-Reply-To: <4C1B2E77.3090404@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 18, 2010 at 1:29 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 06/18/2010 10:21 AM, Jiri Slaby wrote:
>> Holy crap, in docco, there is nothing like that, but I checked gcc
>> parser sources to be sure, and there indeed is:
>> =A0 =A0 =A0asm type-qualifier[opt] ( asm-argument ) ;
>> =A0 =A0 =A0asm type-qualifier[opt] goto ( asm-goto-argument ) ;
>> So yes, asm volatile goto is valid. Would you take care of that?
>
> It is as easy as:
> diff --git a/parse.c b/parse.c
> index caf10b9..1d20658 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1915,7 +1915,8 @@ static struct token *parse_asm_statement(struct
> token *token, struct statement *
> =A0 =A0 =A0 =A0stmt->type =3D STMT_ASM;
> =A0 =A0 =A0 =A0if (match_idents(token, &__volatile___ident, &__volati=
le_ident,
> &volatile_ident, NULL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D token->next;
> - =A0 =A0 =A0 } else if (match_idents(token, &goto_ident, NULL)) {
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (match_idents(token, &goto_ident, NULL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_goto =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D token->next;
> =A0 =A0 =A0 =A0}

Looks good to me.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
