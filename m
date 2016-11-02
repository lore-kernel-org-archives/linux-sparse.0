From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/3] reduce noise from unknown attributes
Date: Thu,  3 Nov 2016 00:07:36 +0100
Message-ID: <20161102230739.64519-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37284 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756406AbcKBXJr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 19:09:47 -0400
Received: by mail-wm0-f45.google.com with SMTP id t79so67194850wmt.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 16:09:47 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently sparse throws error each time at each unknown attributes.

As GCC often creates new attributes, generaly for specific
usages irrelevant to what sparse is used for. The errors from
these not-yet-known attributes create needless noise and annoyance
for no benefits.

This series aims at reduce this noise by doing 3 things:
* change the error to a warning
* add a new flag to disable or enable warnings from those attributes
* by default set this flag as disabled

Change from v1:
 - compile fix for a patch splitting leftover
 - each patch depends on the previous one

Luc Van Oostenryck (3):
  Warn on unknown attributes instead of throwing errors
  Add a new warning flag: '-Wunknown-attribute'
  By default disable the new warning flag '-Wunknown-attribute'

 lib.c                               |  2 ++
 lib.h                               |  1 +
 parse.c                             |  3 ++-
 validation/Wunknown-attribute-def.c |  8 ++++++++
 validation/Wunknown-attribute-no.c  |  9 +++++++++
 validation/Wunknown-attribute-yes.c | 10 ++++++++++
 6 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 validation/Wunknown-attribute-def.c
 create mode 100644 validation/Wunknown-attribute-no.c
 create mode 100644 validation/Wunknown-attribute-yes.c

-- 
2.10.1

