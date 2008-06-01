From: Pavel Roskin <proski@gnu.org>
Subject: Re: spyparse - sparse reimplemented in Python
Date: Sun, 01 Jun 2008 16:33:34 -0400
Message-ID: <1212352414.2727.16.camel@dv>
References: <5b5833aa0805301739o6ceb14a6ha84271b938ee70ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:55762 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbYFAUdg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 16:33:36 -0400
In-Reply-To: <5b5833aa0805301739o6ceb14a6ha84271b938ee70ed@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anderson Lizardo <anderson.lizardo@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Fri, 2008-05-30 at 20:39 -0400, Anderson Lizardo wrote:

> Some notes:
>=20
> - I decided to take a more pragmatic approach and start implementing
> only those functions necessary for writing a test-*.c like backend
> - For now I'm just doing a plain manual translation of the sparse C
> code to Python, thus forcing me to read the entire sparse code (which
> IMHO is a good thing for achieving reason (2))

=EF=BB=BFI'm surprised that you decided to relicense your work under GP=
Lv2.
Even though you are rewriting the code, it's still possible to argue
that the original authors have rights to the code.

It may be safer to use the original license, or you should make sure
that the copyright holders are fine with what you are doing.

> - Along the way I'm rewriting some code to become more OO-friendly
> (with classes, methods etc.), therefore while the code is not finishe=
d
> you will see a lot of mixed procedural and OO code

I think it's a good idea, because sparse should be flexible.  It should
be possible to change it for different coding standards.  A python
implementation would be good, but it would also help if you provide
detailed comments in the code.

--=20
Regards,
Pavel Roskin
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
