From: Chris Forbes <chrisf@ijw.co.nz>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Sun, 28 Aug 2011 14:57:36 +1200
Message-ID: <CAH3ygc01LpeDEY3tmy+ntGH_EC=S7f9AOackWo8dL=5YP6GKkg@mail.gmail.com>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
	<20110828025010.GB20823@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35057 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1H1C5g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 22:57:36 -0400
Received: by gxk21 with SMTP id 21so3925713gxk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 19:57:36 -0700 (PDT)
In-Reply-To: <20110828025010.GB20823@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

> Also, how does your patch handle expressions like this: *x++ && *x++
> Or this: f() && f()

Those cases will both warn. Do I need to be looking for potential side
effects, and considering these expressions "probably correct" in those
cases?

-- Chris
