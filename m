From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] reduce noise from unknown attributes
Date: Wed,  2 Nov 2016 22:59:36 +0100
Message-ID: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38001 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755971AbcKBWBw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 18:01:52 -0400
Received: by mail-wm0-f41.google.com with SMTP id n67so65053898wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 15:01:51 -0700 (PDT)
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

The first patch is independent of the others two.

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

