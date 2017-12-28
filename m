From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] restore CSE of floating-point compares
Date: Thu, 28 Dec 2017 23:17:33 +0100
Message-ID: <20171228221735.38902-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36753 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1WRu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:17:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id b76so45898267wmg.1
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:17:50 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a fix to restore the CSE of
floating point compares which wasn't done anymore after
the introduction of the new FP instructions.

Luc Van Oostenryck (2):
  add testcase for CSE of floating-point compares
  fix: restore CSE on floating-point compares

 cse.c                       |  4 +++-
 validation/optim/cse-fcmp.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/cse-fcmp.c

-- 
2.15.0

