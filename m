From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Mon, 30 Jun 2014 10:27:27 -0700
Message-ID: <CANeU7Q=Tjexvw6LY3ZKiO8B3PvYiFo405DHYpuySJkevwxXeFA@mail.gmail.com>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
	<1402386847-23477-1-git-send-email-phil@dovecot.fi>
	<20140627111900.GA19158@phil.dovecot.net>
	<CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
	<20140630085603.GB19158@phil.dovecot.net>
	<CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:52769 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbaF3R12 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jun 2014 13:27:28 -0400
Received: by mail-qg0-f47.google.com with SMTP id q108so2245635qgd.20
        for <linux-sparse@vger.kernel.org>; Mon, 30 Jun 2014 10:27:27 -0700 (PDT)
In-Reply-To: <CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 30, 2014 at 9:44 AM, Christopher Li <sparse@chrisli.org> wrote:
> That give me 565 new warning. I attach the file here.
>
> I sample some, all the one I saw are false positive.

The real interesting question is, how many real kernel bug in that
565 warnings? It take some human effort to determine the warning
is false positive or not. If most of the warning are false positive, then
the warning is not usable.

Chris
