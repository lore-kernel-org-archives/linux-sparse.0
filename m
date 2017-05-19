From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] use internal size for __INT_MAX__ & friends
Date: Fri, 19 May 2017 13:20:50 +0200
Message-ID: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35072 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbdESLVE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 May 2017 07:21:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id v4so17701594wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 May 2017 04:21:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to predefine macros like __INT_MAX__
with the same size of the one used by sparse while is used to be
size of the machine on which sparse was compiled.

Luc Van Oostenryck (3):
  fix hardcoded size of wide chars
  avoid to redefine __INT_MAX__ and friends
  fix definition of __SCHAR_MAX__ & friends

 char.c   |  4 ++--
 lib.c    | 21 ++++++++++-----------
 target.c |  2 ++
 target.h |  2 ++
 4 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.13.0

