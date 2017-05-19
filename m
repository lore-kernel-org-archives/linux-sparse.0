From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 0/2] avoid warnings for 'bool <- restricted' casts
Date: Fri, 19 May 2017 04:47:00 +0200
Message-ID: <20170519024702.31443-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34409 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbdESCrK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 May 2017 22:47:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so15140344wmf.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 May 2017 19:47:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to stop to emit a warning
when a restricted type is casted to the boolean type
as such conversion is equivalent to a comparision
againts zero for which the 'restrictness' doesn't matter.


Change since v2:
- add tests for assignment to bool type.
- add patch & tests for explicit casts

Changes since v1:
- fix forgotten adjustment of 2 existing test cases.


Luc Van Oostenryck (2):
  avoid warning on implicit 'bool <- restricted' casts
  avoid warning on explicit 'bool <- restricted' casts

 evaluate.c                        | 19 ++++++++++++++---
 validation/bool-cast-bad.c        |  4 ----
 validation/bool-cast-explicit.c   |  4 ----
 validation/bool-cast-implicit.c   |  3 ---
 validation/bool-cast-restricted.c | 43 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 14 deletions(-)
 create mode 100644 validation/bool-cast-restricted.c

-- 
2.13.0

