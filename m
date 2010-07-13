From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 2/2] parser: define __builtin_unreachable
Date: Tue, 13 Jul 2010 11:49:12 -0700
Message-ID: <AANLkTinC0TTj1KLp-l_GWO79V4tX4Q62WVEH77_imEtL@mail.gmail.com>
References: <AANLkTikFmeXz9og4t98jm6QcAdRa6rIeCAv3oeFnTgd8@mail.gmail.com>
	<1278751162-10053-2-git-send-email-jslaby@suse.cz>
	<20100710090705.GA14881@feather>
	<AANLkTimf821jhfhU-Rsj7xa2S4EzuP23weoUSZVWsD2u@mail.gmail.com>
	<20100713181212.GB20289@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45840 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab0GMStO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Jul 2010 14:49:14 -0400
In-Reply-To: <20100713181212.GB20289@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Tue, Jul 13, 2010 at 11:12 AM, Josh Triplett <josh@joshtriplett.org>=
 wrote:
> No, I didn't mean that using __builtin_unreachable should mark the
> function calling it as noreturn. =A0I meant that as an approximation =
to
> the right behavior, __builtin_unreachable *itself* could have attribu=
te
> noreturn.

Ah, that make sense.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
