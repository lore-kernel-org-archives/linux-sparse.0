From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 1/2] parser: fix and simplify support of asm goto
Date: Sat, 10 Jul 2010 11:36:10 -0700
Message-ID: <AANLkTik60ShxdSb8mE0BLGKPmSe3saUTPVHbxCBXqPGp@mail.gmail.com>
References: <AANLkTikFmeXz9og4t98jm6QcAdRa6rIeCAv3oeFnTgd8@mail.gmail.com>
	<1278751162-10053-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64016 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab0GJSgL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Jul 2010 14:36:11 -0400
In-Reply-To: <1278751162-10053-1-git-send-email-jslaby@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sat, Jul 10, 2010 at 1:39 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> + =A0 =A0 =A0 if (token->ident =3D=3D &goto_ident) {

You need to test the token type is TOKEN_IDENT before using token->iden=
t.
I will apply your patch with the fix up.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
