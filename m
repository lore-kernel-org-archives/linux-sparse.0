From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix crash on bad expression in linearize_switch()
Date: Thu, 28 Dec 2017 18:25:17 +0100
Message-ID: <20171228172519.16550-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44192 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbdL1RZh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 12:25:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so44916507wmc.3
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 09:25:37 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This two patches series contains a fix for a crash caused
by a null-pointer dereference when the condition in a switch
contains no expression at all.
As a bonus, sparse now warns on such empty expressions.

Luc Van Oostenryck (2):
  warn on empty parenthesized expressions
  fix crash on bad expression in linearize_switch()

 expression.c            |  6 ++++++
 linearize.c             |  2 ++
 validation/empty-expr.c | 26 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 validation/empty-expr.c

-- 
2.15.0

