From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] validate expression's type in conditionals
Date: Sun, 29 Jan 2017 12:34:06 +0100
Message-ID: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35580 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdA2Mop (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 07:44:45 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so2062553wmu.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 04:44:45 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie aims to detect incorrect types used in conditionals.

Patch 1 fix a test case where a void was used ina conditional.
Patch 2 is an helper for the next patch.
Patch 3 do the validation.

Luc Van Oostenryck (3):
  fix conditional context test case with void
  add helper: is_scalar_type()
  validate expression's type in conditionals

 evaluate.c                    |  5 +++
 symbol.h                      | 22 ++++++++++
 validation/conditional-type.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 validation/context.c          |  2 +-
 4 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 validation/conditional-type.c

-- 
2.11.0

