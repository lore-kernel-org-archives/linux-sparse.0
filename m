From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix dead dominator
Date: Sat, 10 Feb 2018 14:29:43 +0100
Message-ID: <20180210132945.92758-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45196 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeBJNcA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 08:32:00 -0500
Received: by mail-wr0-f196.google.com with SMTP id h9so10862189wre.12
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 05:31:59 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a fix related to the use of a dead
load as dominator in rewrite_load_instruction().

Luc Van Oostenryck (2):
  add testcase of dead dominator
  fix dead dominator

 flow.c                         |  2 +-
 validation/mem2reg/load-dead.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 validation/mem2reg/load-dead.c

-- 
2.16.0

