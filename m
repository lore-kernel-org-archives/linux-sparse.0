From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] add helper predefine_{strong,weak}()
Date: Sun,  5 Jul 2020 15:16:02 +0200
Message-ID: <20200705131605.26551-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgGENQN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:16:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4780C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:16:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so20953869ejb.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:16:12 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A lot of predefined macros are just set to the value '1'.
So, create a pair of helper for this and use it to limit
the use of add_pre_buffer() in target-specific files.


Luc Van Oostenryck (2):
  predefine: add helper predefine_{strong,weak}()
  predefine: avoid add_pre_buffer() for targets

 lib.h          |  2 ++
 pre-process.c  | 26 ++++++++++++++++++++++++++
 target-arm64.c |  2 +-
 target-riscv.c |  2 +-
 4 files changed, 30 insertions(+), 2 deletions(-)


base-commit: 88c90bb192663bfc2dc54782c316e39e6fe26e1d
-- 
2.27.0
