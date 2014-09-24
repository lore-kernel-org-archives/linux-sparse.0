From: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: spurious warning for sizeof(bool)
Date: Wed, 24 Sep 2014 19:40:46 -0400
Message-ID: <CAJhHMCDhai4WxRg5_1PQXq=MpO4a6Eyv9+Ep7hu09irnqJVHDg@mail.gmail.com>
References: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:37377 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaIXXlS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 19:41:18 -0400
Received: by mail-vc0-f169.google.com with SMTP id id10so6300076vcb.14
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 16:41:17 -0700 (PDT)
In-Reply-To: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>

Is anyone reading these emails? :)

On Tue, Sep 23, 2014 at 11:37 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Hello,
>
> I am getting these spurious warnings for a sizeof(bool) expression
>
> kernel/rcu/tree.c:202:14: warning: expression using sizeof bool
>
> Is this going to be fixed anytime soon?
>
> Thanks!
> --
> Pranith



-- 
Pranith
