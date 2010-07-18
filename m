From: Morten Welinder <mortenw@gnome.org>
Subject: Spurious symbol 'foo' was not declared
Date: Sun, 18 Jul 2010 16:16:37 -0400
Message-ID: <AANLkTikqtMvb3fdg4aKR1KStEBhg1yDM-0YpR0VGHtiT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52603 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab0GRUQj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 18 Jul 2010 16:16:39 -0400
Received: by vws5 with SMTP id 5so4031129vws.19
        for <linux-sparse@vger.kernel.org>; Sun, 18 Jul 2010 13:16:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I think sparse issues a spurious warning about "static" for this progra=
m.
Right?

Morten

static void foo (int);
void foo (int a) { }

welinder@anemone:~> cgcc -Wall -c sss.c
sss.c:2:6: warning: symbol 'foo' was not declared. Should it be static?
sss.c:2: warning: =91foo=92 defined but not used
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
