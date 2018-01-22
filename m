From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix ignored type attributes
Date: Mon, 22 Jan 2018 07:36:02 +0100
Message-ID: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46362 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeAVGgQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 01:36:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so14090870wma.5
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jan 2018 22:36:16 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These patches contains a fix for struct/union/enum
attributes that were wrongly either ignored or
associated with the subsequent variables if present.

These patches are available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git fix-ignored-type-attributes

Luc Van Oostenryck (3):
      add testcases for ignored type attributes
      move up apply_ctype()'s declaration
      fix: do not ignore struct/union/enum type attributes

 parse.c                           |  9 +++++++--
 validation/type-attribute-align.c | 19 +++++++++++++++++++
 validation/type-attribute-as.c    | 33 +++++++++++++++++++++++++++++++++
 validation/type-attribute-mod.c   | 21 +++++++++++++++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 validation/type-attribute-align.c
 create mode 100644 validation/type-attribute-as.c
 create mode 100644 validation/type-attribute-mod.c
