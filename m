From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] kill dead loads
Date: Thu,  8 Jun 2017 09:39:24 +0200
Message-ID: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36232 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdFHHjh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Jun 2017 03:39:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so1029825wme.3
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jun 2017 00:39:36 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to eliminate dead loads which,
especially the deadborn ones which, until now, weren't
removed.

This series is also available in the git repository at:
  git://github.com/lucvoo/sparse.git kill-dead-loads

Luc Van Oostenryck (3):
      extract has_users() from dead_insn()
      let kill_instruction() report if it made some changes or not
      kill dead loads

 flow.h                       | 10 +++++-----
 simplify.c                   | 40 +++++++++++++++++++++++++---------------
 validation/optim/load-dead.c | 11 +++++++++++
 3 files changed, 41 insertions(+), 20 deletions(-)
 create mode 100644 validation/optim/load-dead.c
