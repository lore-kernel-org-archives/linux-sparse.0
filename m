From: Pranith Kumar <bobby.prani@gmail.com>
Subject: spurious warning for sizeof(bool)
Date: Tue, 23 Sep 2014 11:37:44 -0400
Message-ID: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:38596 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbaIWPiP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Sep 2014 11:38:15 -0400
Received: by mail-vc0-f178.google.com with SMTP id lf12so3120531vcb.23
        for <linux-sparse@vger.kernel.org>; Tue, 23 Sep 2014 08:38:14 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>

Hello,

I am getting these spurious warnings for a sizeof(bool) expression

kernel/rcu/tree.c:202:14: warning: expression using sizeof bool

Is this going to be fixed anytime soon?

Thanks!
-- 
Pranith
